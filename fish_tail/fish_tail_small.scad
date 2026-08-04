use <fish_tail.scad>;
use <../mounting_functions.scad>;

height = 180;
layer_height = 0.2;
main_diameter = 80;
divs_per_circle = 24; //24
spiral_radius = 6; // unused by fish_tail() — kept from the original design, not currently wired into the geometry
circle_diameter = 42; //42
swell = 20;
center_hole_diameter = 40;

difference() {
    fish_tail(
        height = height,
        layer_height = layer_height,
        main_diameter = main_diameter,
        divs_per_circle = divs_per_circle,
        circle_diameter = circle_diameter,
        swell = swell
    );
    center_hole(height = height, diameter = center_hole_diameter);
}
