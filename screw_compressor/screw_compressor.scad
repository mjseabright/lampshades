use <../geometry_functions.scad>;

module screw_compressor(height = 180, layer_height = 0.2, main_diameter = 70, divs_per_circle = 3, spiral_radius = 0, circle_radius = 80, swell = 0) {
    for (h = [0:layer_height:height]) {
        translate([0,0,h]) rotate([0,0,0]) {
            linear_extrude(layer_height) {
                union() {
                    for (t = [0:360/divs_per_circle:360]) {
                        rotate([0,0,t]) translate([main_diameter/2 + swell*sin((h/height)*180),0,0]) {
                            rotate([0,0,h*8]) translate([spiral_radius,0,0]) rotate([0,0,-h*7.5]) regular_polygon(order=6, r=circle_radius/2 + (20 * sin((h/height)*180)));
                        }
                    }
                }
            }
        }
    }
}

// Standalone preview with default parameters
screw_compressor();
