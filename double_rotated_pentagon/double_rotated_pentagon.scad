use <../geometry_functions.scad>;

module double_rotated_pentagon(height = 180, layer_height = 0.2, main_radius = 70) {
    union() {
        for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,(a/height) * 2 * 180 / 2.5]){
                linear_extrude(layer_height) {
                    regular_polygon(order=5, r=main_radius + 35*sin((a/height)*180));
                }
            }
         }

        for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,-(a/height) * 2 * 180 / 2.5]){
                linear_extrude(layer_height) {
                    regular_polygon(order=5, r=main_radius + 35*sin((a/height)*180));
                }
            }
        }
    }
}

// Standalone preview with default parameters
double_rotated_pentagon();
