use <foot.scad>;

length = 15;          // total length, flat end to point (mm)
outer_diameter = 10;  // diameter of the cylindrical body (mm)
hole_diameter = 5.7;  // diameter of the center hole, sized for a press-fit threaded insert (mm)
hole_depth = 9;       // depth of the center hole, from the flat end (mm)

foot(
    length = length,
    outer_diameter = outer_diameter,
    hole_diameter = hole_diameter,
    hole_depth = hole_depth
);
