use <../bases/low_pro_with_adaptor.scad>;

// Copied from turbine_large.scad -- keep these in sync with that file so the
// base's spokes/foot holes/mount bore line up with the shade.
divs_per_circle = 3;      // number of blades/spokes; must match divs_per_circle in turbine_large.scad
foot_hole_diameter = 4.5; // must match foot_hole_diameter in turbine_large.scad (mm)
foot_hole_radius = 70;    // must match foot_hole_radius in turbine_large.scad (mm)
mount_od = 40;            // outer diameter of the central adaptor-mount boss; must match center_hole_diameter in turbine_large.scad (mm)

// TODO: tune these
spoke_width = 10;          // width of each spoke at its tip, i.e. at the foot-mounting hole (mm)
spoke_width_center = 15;  // width of each spoke at the center mount, tapering down to spoke_width at the tip (mm)
spoke_height = 2;         // height of each spoke (mm)
mount_id = 33;            // inner diameter of the central adaptor-mount boss, i.e. the bore the adaptor sits in (mm)
mount_height = 30;         // height of the central adaptor-mount boss (mm)
mount_hole_diameter = 28; // diameter of the fixing hole(s) through the mount boss (mm)

low_pro_with_adaptor(
    num_spokes = divs_per_circle,
    foot_hole_diameter = foot_hole_diameter,
    foot_hole_radius = foot_hole_radius,
    spoke_width = spoke_width,
    spoke_width_center = spoke_width_center,
    spoke_height = spoke_height,
    mount_od = mount_od,
    mount_id = mount_id,
    mount_height = mount_height,
    mount_hole_diameter = mount_hole_diameter
);
