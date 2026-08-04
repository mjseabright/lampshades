use <screw_compressor.scad>;
use <../mounting_functions.scad>;

height = 180;
layer_height = 0.2;
main_diameter = 70;
divs_per_circle = 3;
spiral_radius = 0;
circle_radius = 80;
swell = 0;
center_hole_diameter = 40;

difference() {
    screw_compressor(
        height = height,
        layer_height = layer_height,
        main_diameter = main_diameter,
        divs_per_circle = divs_per_circle,
        spiral_radius = spiral_radius,
        circle_radius = circle_radius,
        swell = swell
    );
    center_hole(height = height, diameter = center_hole_diameter);
}
