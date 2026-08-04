use <low_profile_foot.scad>;

length = 15;          // total length, flat end to point (mm)
outer_diameter = 10;  // diameter of the cylindrical body (mm)
hole_diameter = 3.8;  // diameter of the center hole, sized for a screw to thread directly into the plastic (mm)
hole_depth = 9;       // depth of the center hole, from the flat end (mm)

foot(
    length = length,
    outer_diameter = outer_diameter,
    hole_diameter = hole_diameter,
    hole_depth = hole_depth
);
