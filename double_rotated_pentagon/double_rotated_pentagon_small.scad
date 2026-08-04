use <double_rotated_pentagon.scad>;
use <../mounting_functions.scad>;

height = 180;
layer_height = 0.2;
main_radius = 70;
center_hole_diameter = 40;

difference() {
    double_rotated_pentagon(height = height, layer_height = layer_height, main_radius = main_radius);
    center_hole(height = height, diameter = center_hole_diameter);
}
