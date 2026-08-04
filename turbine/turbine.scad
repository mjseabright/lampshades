use <../geometry_functions.scad>;

// Main turbine blade geometry, with no base/mounting features (center hole,
// foot holes, etc.) — those are added by the files that use this module,
// so the same blade shape can be reused across different size/mount configs.
module turbine(
    height = 240,
    layer_height = 0.2,
    main_diameter = 80,
    divs_per_circle = 3,
    blade_sides = 5,
    circle_radius = 60,
    blade_swell = 32,
    blade_rotations = 1
) {
    for (h = [0:layer_height:height]) {
        translate([0,0,h]) rotate([0,0,0]) {
            linear_extrude(layer_height) {
                union() {
                    for (t = [0:360/divs_per_circle:360]) {
                        rotate([0,0,t]) translate([main_diameter/2,0,0]) {
                            rotate([0,0,350/blade_sides/2]) // fixed per-blade orientation offset (roughly half a polygon sector), doesn't change with height
                            rotate([0,0,h*(blade_rotations*360/height)]) regular_polygon(order=blade_sides, r=circle_radius + (blade_swell * sin((h/height)*180)));
                        }
                    }
                }
            }
        }
    }
}

// Standalone preview with default parameters
turbine();
