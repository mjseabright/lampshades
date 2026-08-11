// Low-profile lampshade base with an integrated adaptor mount: a spoked disc
// with straight foot-mounting holes around its rim and a central boss that
// the adaptor (see ../adaptor/adaptor.scad) mounts into.
//
// Placeholder: geometry not yet implemented -- currently just previews the
// mount boss and foot-hole positions so the parameter set can be wired up
// and iterated on before the spoke/rim shape is designed.
module low_pro_with_adaptor(
    num_spokes = 3,             // number of spokes joining the rim to the center mount (also the number of foot-mounting holes, one per spoke)
    foot_hole_diameter = 4.5,   // diameter of each straight foot-mounting hole, bottom to top (mm)
    foot_hole_radius = 70,      // radius from center at which the foot-mounting holes sit, one per spoke, on the spoke's centerline (mm)
    spoke_width = 6,            // width of each spoke at its tip, i.e. at the foot-mounting hole (mm)
    spoke_width_center = 12,    // width of each spoke at the center mount, tapering down to spoke_width at the tip (mm)
    spoke_height = 3,           // height of each spoke (mm)
    mount_od = 40,              // outer diameter of the central adaptor-mount boss (mm)
    mount_id = 33,               // inner diameter of the central adaptor-mount boss, i.e. the bore the adaptor sits in (mm)
    mount_height = 30,           // height of the central adaptor-mount boss (mm)
    mount_hole_diameter = 28   // diameter of the fixing hole(s) through the mount boss, e.g. for a self-tapping screw into the adaptor (mm)
) {
    union() {    
        difference() {
            union() {
                cylinder(h = mount_height + spoke_height, d = mount_od, $fn = 64);
                cylinder(h = spoke_height, d = mount_od + 15, $fn = 64);
                for (n = [0:1:num_spokes]) {
                    rotate([0,0,n*360/num_spokes]) {
                        linear_extrude(spoke_height) {
                            difference() {
                                union() {
                                    polygon(points = [
                                        [0, spoke_width_center/2],
                                        [foot_hole_radius, spoke_width/2],
                                        [foot_hole_radius, -spoke_width/2],
                                        [0, -spoke_width_center/2]
                                    ]);
                                    translate([foot_hole_radius,0,-1]) circle(d = spoke_width, $fn = 32);
                                }
                                translate([foot_hole_radius,0,-1]) circle(d = foot_hole_diameter, $fn = 32);
                            }
                        }
                    }
                }
            }
            translate([0, 0, -1]) cylinder(h = mount_height + spoke_height - 1, d = mount_id, $fn = 64);
            translate([0, 0, -1]) cylinder(h = mount_height + spoke_height + 2, d = mount_hole_diameter, $fn = 64);
        }        
    }
}

// Standalone preview with default parameters
low_pro_with_adaptor();
