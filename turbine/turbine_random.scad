use <../geometry_functions.scad>;

// Interpolates across a list of control-point values sitting at the given
// (ascending, first=0, last=1) positions along frac=[0,1]. Used to turn a
// handful of rands() values into smooth, low-frequency noise instead of
// per-layer static. Eased with smoothstep (rather than plain linear) so the
// blend has zero slope at each control point -- this removes the sharp kinks
// a linear blend leaves right at the control points, giving a continuously
// smooth curve.
function interp_noise(frac, positions, values) =
    let(n = len(positions) - 1)
    let(i = min(max(len([for (p = positions) if (p <= frac) p]) - 1, 0), n - 1))
    let(width = max(positions[i + 1] - positions[i], 0.0000001)) // avoid divide-by-zero if two control points land on top of each other
    let(local_frac = (frac - positions[i]) / width)
    let(eased_frac = local_frac * local_frac * (3 - 2 * local_frac))
    values[i] * (1 - eased_frac) + values[i + 1] * eased_frac;

// Evenly spaced control-point positions over frac=[0,1] for a list of n values.
function even_positions(n) = [for (idx = [0:n-1]) idx / (n - 1)];

// Same as turbine.scad's blade geometry, but with the twist rate and swell
// perturbed by smooth per-height noise, and each blade given its own
// deterministic random seed so blades no longer twist/swell in lockstep.
module turbine_random(
    height = 240,
    layer_height = 0.2,
    main_diameter = 80,
    divs_per_circle = 3,
    blade_sides = 5,
    circle_radius = 60,
    blade_swell = 32,
    blade_rotations = 1,
    noise_seed = 1,                  // seed for all randomness -- change this to get a different (but still deterministic/reproducible) result
    twist_noise_points = 6,          // number of control points for twist-rate noise across the full height
    twist_noise_amount = 15,         // max degrees of extra twist jitter at a control point
    twist_noise_height_randomness = 0.6, // 0-1: how much each twist control point's height can shift away from even spacing (0 = evenly spaced, 1 = max jitter without adjacent points crossing)
    swell_noise_points = 6,          // number of control points for swell noise across the full height
    swell_noise_amount = 8,          // max mm of extra/less swell at a control point
    blade_phase_noise_amount = 10,   // max degrees of per-blade fixed rotation offset (breaks radial symmetry between blades)
    blade_swell_noise_amount = 6     // max mm of per-blade swell amplitude variation
) {
    for (h = [0:layer_height:height]) {
        translate([0,0,h]) rotate([0,0,0]) {
            linear_extrude(layer_height) {
                union() {
                    for (t = [0:360/divs_per_circle:360]) {
                        blade_seed = noise_seed + (t % 360) * 10;
                        raw_twist_points = rands(-twist_noise_amount, twist_noise_amount, twist_noise_points, blade_seed);
                        // force the first/last control points to 0 so the twist rate
                        // matches the un-noised spiral exactly at the top and bottom
                        twist_points = [for (idx = [0:len(raw_twist_points)-1])
                            (idx == 0 || idx == len(raw_twist_points)-1) ? 0 : raw_twist_points[idx]];

                        // randomize the *height* of each twist control point too, instead of
                        // leaving them evenly spaced. Jitter is capped at half the even spacing
                        // so adjacent points can shift towards each other but never cross.
                        twist_spacing = 1 / (twist_noise_points - 1);
                        twist_height_jitter_amount = (twist_spacing / 2) * twist_noise_height_randomness;
                        raw_twist_position_jitters = rands(-twist_height_jitter_amount, twist_height_jitter_amount, twist_noise_points, blade_seed + 5000);
                        twist_positions = [for (idx = [0:twist_noise_points-1])
                            (idx == 0) ? 0 :
                            (idx == twist_noise_points-1) ? 1 :
                            idx * twist_spacing + raw_twist_position_jitters[idx]];

                        swell_points = rands(-swell_noise_amount, swell_noise_amount, swell_noise_points, blade_seed + 1000);
                        phase_offset = rands(-blade_phase_noise_amount, blade_phase_noise_amount, 1, blade_seed + 2000)[0];
                        swell_amp_offset = rands(-blade_swell_noise_amount, blade_swell_noise_amount, 1, blade_seed + 3000)[0];

                        frac = h / height;
                        twist_jitter = interp_noise(frac, twist_positions, twist_points);
                        swell_jitter = interp_noise(frac, even_positions(swell_noise_points), swell_points);
                        envelope = sin(frac*180);
                        r = circle_radius + ((blade_swell + swell_amp_offset) + swell_jitter) * envelope;

                        rotate([0,0,t]) translate([main_diameter/2,0,0]) {
                            rotate([0,0,350/blade_sides/2]) // fixed per-blade orientation offset (roughly half a polygon sector), doesn't change with height
                            rotate([0,0,h*(blade_rotations*360/height) + twist_jitter + phase_offset]) regular_polygon(order=blade_sides, r=r);
                        }
                    }
                }
            }
        }
    }
}

// Standalone preview with default parameters
turbine_random();
