use <rope_swirl.scad>;
use <../mounting_functions.scad>;

height = 180;
layer_height = 0.2;
main_diameter = 120;
divs_per_circle = 36;
spiral_radius = 6;
circle_diameter = 12.5;
swell = 15;
circle_sides = 10;
orbit_deg_per_mm = 4;
spin_deg_per_mm = 8;
center_hole_diameter = 40;

difference() {
    rope_swirl(
        height = height,
        layer_height = layer_height,
        main_diameter = main_diameter,
        divs_per_circle = divs_per_circle,
        spiral_radius = spiral_radius,
        circle_diameter = circle_diameter,
        swell = swell,
        circle_sides = circle_sides,
        orbit_deg_per_mm = orbit_deg_per_mm,
        spin_deg_per_mm = spin_deg_per_mm
    );
    center_hole(height = height, diameter = center_hole_diameter);
}
