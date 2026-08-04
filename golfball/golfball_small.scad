use <golfball.scad>;
use <../mounting_functions.scad>;

height = 180;
swell = 60;
layer_height = 0.2;
main_diameter = 120;
dimple_radius = 5; // unused by golfball() — kept from the original design, not currently wired into the geometry
dimple_v_spacing = 6;
num_dimple_per_rot = 50;
center_hole_diameter = 40;

difference() {
    golfball(
        height = height,
        swell = swell,
        layer_height = layer_height,
        main_diameter = main_diameter,
        dimple_v_spacing = dimple_v_spacing,
        num_dimple_per_rot = num_dimple_per_rot
    );
    center_hole(height = height, diameter = center_hole_diameter);
}
