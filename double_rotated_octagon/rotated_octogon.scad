use <../geometry_functions.scad>;

module rotated_octogon(height = 180, layer_height = 0.2, main_radius = 70) {
    union() {
        for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,(a/height) * 2 * 180 / 2]){
                linear_extrude(layer_height) {
                    regular_polygon(order=8, r=main_radius + 30*sin((a/height)*180));
                }
            }
        }

        rotate([0,0,360/16]) for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,-(a/height) * 2 * 180 / 2]){
                linear_extrude(layer_height) {
                    regular_polygon(order=8, r=main_radius + 30*sin((a/height)*180));
                }
            }
        }
    }
}

// Standalone preview with default parameters
rotated_octogon();
