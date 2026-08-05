// Low-profile lampshade base with an integrated adaptor mount: a spoked disc
// with straight foot-mounting holes around its rim and a central boss that
// the adaptor (see ../adaptor/adaptor.scad) mounts into.
//
// Placeholder: geometry not yet implemented -- currently just previews the
// mount boss and foot-hole positions so the parameter set can be wired up
// and iterated on before the spoke/rim shape is designed.
module low_pro_with_adaptor(
    num_spokes = 6,             // number of spokes joining the rim to the center mount (also the number of foot-mounting holes, one per spoke)
    foot_hole_diameter = 4.2,   // diameter of each straight foot-mounting hole, bottom to top (mm)
    foot_hole_radius = 70,      // radius from center at which the foot-mounting holes sit, one per spoke, on the spoke's centerline (mm)
    spoke_width = 6,            // width of each spoke (mm)
    spoke_height = 8,           // height of each spoke (mm)
    mount_od = 55,              // outer diameter of the central adaptor-mount boss (mm)
    mount_id = 28,               // inner diameter of the central adaptor-mount boss, i.e. the bore the adaptor sits in (mm)
    mount_height = 8,           // height of the central adaptor-mount boss (mm)
    mount_hole_diameter = 3.2   // diameter of the fixing hole(s) through the mount boss, e.g. for a self-tapping screw into the adaptor (mm)
) {
    // TODO: replace with actual base geometry (rim, spokes, foot holes).
    difference() {
        cylinder(h = mount_height, d = mount_od, $fn = 64);
        translate([0, 0, -1])
            cylinder(h = mount_height + 2, d = mount_id, $fn = 64);
    }
}

// Standalone preview with default parameters
low_pro_with_adaptor();
