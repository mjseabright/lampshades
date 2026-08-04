use <turbine.scad>;
use <../mounting_functions.scad>;

height = 180;
layer_height = 1.0;
main_diameter = 70;
divs_per_circle = 3;
blade_sides = 5;
circle_radius = 45;
blade_swell = 15;
blade_rotations = 0.75;
center_hole_diameter = 40; // diameter of the hole through the center of the shade, for mounting on the adaptor (mm)


difference() {
    turbine(
        height = height,
        layer_height = layer_height,
        main_diameter = main_diameter,
        divs_per_circle = divs_per_circle,
        blade_sides = blade_sides,
        circle_radius = circle_radius,
        blade_swell = blade_swell,
        blade_rotations = blade_rotations
    );

    center_hole(height = height, diameter = center_hole_diameter);
}
