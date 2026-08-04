use <pineapple.scad>;
use <../mounting_functions.scad>;

height = 180;
layer_height = 0.2;
main_diameter = 130;
num_angle_divs = 40;
center_hole_diameter = 40;

difference() {
    pineapple(height = height, layer_height = layer_height, main_diameter = main_diameter, num_angle_divs = num_angle_divs);
    center_hole(height = height, diameter = center_hole_diameter);
}
