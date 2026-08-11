use <../geometry_functions.scad>;

// Low-profile lampshade base with an integrated adaptor mount: a spoked disc
// with straight foot-mounting holes around its rim and a central boss that
// the light fitting mounts into.

module low_pro_with_adaptor(
    num_spokes = 3,             // number of spokes joining the rim to the center mount (also the number of foot-mounting holes, one per spoke)
    foot_hole_diameter = 4.5,   // diameter of each straight foot-mounting hole, bottom to top (mm)
    foot_hole_radius = 70,      // radius from center at which the foot-mounting holes sit, one per spoke, on the spoke's centerline (mm)
    spoke_width = 10,            // width of each spoke at its tip, i.e. at the foot-mounting hole (mm)
    spoke_width_center = 15,    // width of each spoke at the center mount, tapering down to spoke_width at the tip (mm)
    spoke_height = 3,           // height of each spoke (mm)
    mount_od = 40,              // outer diameter of the central adaptor-mount boss (mm)
    mount_id = 33,               // inner diameter of the central adaptor-mount boss, i.e. the bore the adaptor sits in (mm)
    mount_height = 30,           // height of the central adaptor-mount boss (mm)
    mount_hole_diameter = 28,   // diameter of the fixing hole(s) through the mount boss, e.g. for a self-tapping screw into the adaptor (mm)
    mount_lip_height = 2,       // thickness of the solid lip capping the top of the mount_id bore, which the adaptor seats against (mm)
    chamfer = 0.5                // chamfer applied to every top/bottom (XY-plane-facing) edge (mm). Note: this does not chamfer the interior step edge where the base disc's top face meets the mount boss's wall, nor the internal corner where the mount_id bore meets the underside of the top lip.
) {
    mount_body_height = mount_height + spoke_height - mount_lip_height;
    union() {
        difference() {
            union() {
                // Main boss body: chamfered at its real bottom face; flat at the
                // top, where it's a hidden seam under the lip.
                chamfered_cylinder(h = mount_body_height, d = mount_od, chamfer = chamfer, fn = 64, chamfer_top = false);
                // Top lip: flat at the bottom, matching the seam; chamfered at
                // its top, which is the mount's real top face.
                translate([0, 0, mount_body_height])
                    chamfered_cylinder(h = mount_lip_height, d = mount_od, chamfer = chamfer, fn = 64, chamfer_bottom = false);
                chamfered_cylinder(h = spoke_height, d = mount_od + 15, chamfer = chamfer, fn = 64);
                for (n = [0:1:num_spokes]) {
                    rotate([0,0,n*360/num_spokes]) {
                        difference() {
                            chamfered_extrude(h = spoke_height, chamfer = chamfer) {
                                union() {
                                    polygon(points = [
                                        [0, spoke_width_center/2],
                                        [foot_hole_radius, spoke_width/2],
                                        [foot_hole_radius, -spoke_width/2],
                                        [0, -spoke_width_center/2]
                                    ]);
                                    translate([foot_hole_radius,0]) circle(d = spoke_width, $fn = 32);
                                }
                            }
                            translate([foot_hole_radius,0,0]) chamfered_hole(h = spoke_height, d = foot_hole_diameter, chamfer = chamfer, fn = 32);
                        }
                    }
                }
            }
            // Blind at the top (under the lip) -- no chamfer on that internal corner.
            chamfered_hole(h = mount_body_height, d = mount_id, chamfer = chamfer, fn = 64, chamfer_top = false);            
            translate([0, 0, mount_body_height])
                chamfered_hole(h = mount_lip_height, d = mount_hole_diameter, chamfer = chamfer, fn = 64);
        }
    }
}

// Standalone preview with default parameters
low_pro_with_adaptor();
