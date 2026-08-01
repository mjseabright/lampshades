module regular_polygon(order = 5, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

height = 240;             // total height of the lampshade (mm)
layer_height = 0.2;       // vertical distance between cross-sections (mm); match to your printer's layer height
main_diameter = 80;     // diameter of the ring the blades are centered on, before adding blade radius (mm)
divs_per_circle = 3;      // number of blades repeated around the circle
blade_sides = 5;          // number of sides of each blade's polygon shape (e.g. 5 = pentagon); also sets each blade's fixed rotational alignment below
circle_radius = 60;     // radius of each blade's polygon shape (mm)
blade_swell = 32;       // amplitude of the sine bulge applied to each blade's own radius over the height (mm)
blade_rotations = 1;  // number of full 360° spins of each blade over the whole height (negative = reverse spin direction)
center_hole_diameter = 40; // diameter of the hole through the center of the shade, for mounting on the adaptor (mm)
foot_hole_diameter = 4.2; // diameter of each straight foot-mounting hole, bottom to top (mm)
foot_hole_radius = 70;    // radius from the shade's center at which the foot-mounting holes sit, one per blade, on the line from center through that blade's center (mm)


difference() {
    for (h = [0:layer_height:height]) {
        translate([0,0,h]) rotate([0,0,0]) {
            linear_extrude(layer_height) {
                difference() {
                    union() {
                        for (t = [0:360/divs_per_circle:360]) {
                            rotate([0,0,t]) translate([main_diameter/2,0,0]) {
                                rotate([0,0,350/blade_sides/2]) // fixed per-blade orientation offset (roughly half a polygon sector), doesn't change with height
                                rotate([0,0,h*(blade_rotations*360/height)]) regular_polygon(order=blade_sides, r=circle_radius + (blade_swell * sin((h/height)*180)));
                            }
                        }
                    }
                    circle(d=center_hole_diameter, $fa=1);
                }
            }
        }
    }
    // one straight vertical foot-mounting hole per blade, same angle as the blade, at foot_hole_radius, full height
    for (t = [0:360/divs_per_circle:360]) {
        rotate([0,0,t]) translate([foot_hole_radius,0,-1])
            cylinder(h=height+layer_height+2, d=foot_hole_diameter, $fn=24);
    }
}
