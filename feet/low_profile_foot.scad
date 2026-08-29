// Small bullet-shaped foot: a cylindrical body tapering at the bottom to a
// rounded point, with a straight hole in the flat top end for a fixing
// (threaded insert or self-tapping screw). Variant files use this module and
// only override hole_diameter, so the insert/plastic-thread versions stay
// identical apart from that one dimension.
//
// The nose is a cubic bezier profile (apex to shoulder), revolved with
// rotate_extrude: horizontal tangent at the apex (rounded point, not sharp)
// and vertical tangent at the shoulder (flush with the cylindrical side, no
// sharp corner there either). Weighting the shoulder-side tangent handle
// much longer than the apex-side one keeps the profile close to
// outer_diameter for most of nose_height, only curving in sharply right at
// the point.
module foot(
    length = 20,               // total length, flat end to point (mm)
    outer_diameter = 10,       // diameter of the cylindrical body (mm)
    hole_diameter = 5.7,       // diameter of the center hole in the flat end (mm)
    hole_depth = 9,            // depth of the center hole, from the flat end (mm)
    nose_height = 8,           // height of the rounded nose, from the point up to where it meets the straight side (mm)
    nose_top_tangent = 1,   // 0-1 fraction of nose_height: how long the profile stays vertical (at outer_diameter) before curving in -- higher = longer straight run, sharper turn near the point
    nose_bottom_tangent = 0.5, // 0-1 fraction of outer_radius: how long the profile stays horizontal right at the point -- higher = flatter/rounder point, lower = sharper point
    nose_segments = 24         // number of line segments used to approximate the bezier nose profile
) {
    outer_radius = outer_diameter / 2;
    apex = [0, 0];                    // bottom point, on the axis
    shoulder = [outer_radius, nose_height]; // where the nose meets the straight cylindrical side

    b1 = apex + [outer_radius * nose_bottom_tangent, 0];
    b2 = shoulder - [0, nose_height * nose_top_tangent];

    nose_curve = [ for (t = [0 : 1/nose_segments : 1])
        let (mt = 1 - t)
        mt*mt*mt*apex + 3*mt*mt*t*b1 + 3*mt*t*t*b2 + t*t*t*shoulder
    ];

    outer_profile = concat(
        nose_curve,
        [[outer_radius, length], [0, length]] // straight up the side, then across the flat top back to the axis
    );

    difference() {
        rotate_extrude($fn=64) polygon(outer_profile);

        // center hole, cut down from the flat top end
        translate([0,0,length-hole_depth]) cylinder(h=hole_depth+1, d=hole_diameter, $fn=64);
    }
}

// Standalone preview with default parameters
foot();
