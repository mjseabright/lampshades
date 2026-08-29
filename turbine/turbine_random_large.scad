use <turbine_random.scad>;
use <../mounting_functions.scad>;

height = 240;             // total height of the lampshade (mm)
layer_height = 0.2;       // vertical distance between cross-sections (mm); match to your printer's layer height
main_diameter = 90;     // diameter of the ring the blades are centered on, before adding blade radius (mm)
divs_per_circle = 3;      // number of blades repeated around the circle
blade_sides = 5;          // number of sides of each blade's polygon shape (e.g. 5 = pentagon); also sets each blade's fixed rotational alignment below
circle_radius = 54;     // radius of each blade's polygon shape (mm)
blade_swell = 32;       // amplitude of the sine bulge applied to each blade's own radius over the height (mm)
blade_rotations = 5/5;  // number of full 360° spins of each blade over the whole height (negative = reverse spin direction)
center_hole_diameter = 40; // diameter of the hole through the center of the shade, for mounting on the adaptor (mm)
foot_hole_diameter = 4.5; // diameter of each straight foot-mounting hole, bottom to top (mm)
foot_hole_radius = 70;    // radius from the shade's center at which the foot-mounting holes sit, one per blade, on the line from center through that blade's center (mm)
noise_seed = 3;                  // seed for all randomness -- change this to get a different (but still deterministic/reproducible) result
twist_noise_points = 5;          // number of control points for twist-rate noise across the full height
twist_noise_amount = 20;         // max degrees of extra twist jitter at a control point
twist_noise_height_randomness = 0.6; // 0-1: how much each twist control point's height can shift away from even spacing (0 = evenly spaced, 1 = max jitter without adjacent points crossing)
swell_noise_points = 6;          // number of control points for swell noise across the full height
swell_noise_amount = 0;          // max mm of extra/less swell at a control point
blade_phase_noise_amount = 0;   // max degrees of per-blade fixed rotation offset (breaks radial symmetry between blades)
blade_swell_noise_amount = 0;    // max mm of per-blade swell amplitude variation


difference() {
    turbine_random(
        height = height,
        layer_height = layer_height,
        main_diameter = main_diameter,
        divs_per_circle = divs_per_circle,
        blade_sides = blade_sides,
        circle_radius = circle_radius,
        blade_swell = blade_swell,
        blade_rotations = blade_rotations,
        noise_seed = noise_seed,
        twist_noise_points = twist_noise_points,
        twist_noise_amount = twist_noise_amount,
        twist_noise_height_randomness = twist_noise_height_randomness,
        swell_noise_points = swell_noise_points,
        swell_noise_amount = swell_noise_amount,
        blade_phase_noise_amount = blade_phase_noise_amount,
        blade_swell_noise_amount = blade_swell_noise_amount
    );

    // base/mounting geometry: center adaptor hole + one straight vertical
    // foot-mounting hole per blade, same angle as the blade, at foot_hole_radius
    union() {
        center_hole(height = height, diameter = center_hole_diameter);
        foot_holes(hole_diameter = foot_hole_diameter, pattern_radius = foot_hole_radius, num_holes = divs_per_circle, height = height);
    }
}
