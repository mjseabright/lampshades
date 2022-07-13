module regular_polygon(order = 5, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

height = 180;
layer_height = 0.2;
main_diameter = 80;
divs_per_circle = 24; //24
spiral_radius = 6;
circle_diameter = 42; //42
swell = 20;

for (h = [0:layer_height:height]) {
    translate([0,0,h]) rotate([0,0,0]) {
        linear_extrude(layer_height) {
            difference() {
                union() {
                    for (t = [0:360/(divs_per_circle/2):360]) {
                        rotate([0,0,t]) translate([main_diameter/2 + swell*sin((h/height)*180),0,0]) {
                            rotate([0,0,h*8]) regular_polygon(order=7, r=circle_diameter/2 + (4 * sin((1*h/height)*180)));
                        }
                    }
                    for (t = [0:360/(divs_per_circle/2):360]) {
                        rotate([0,0,t+(360/divs_per_circle)]) translate([main_diameter/2 + swell*sin((h/height)*180),0,0]) {
                        // rotate([0,0,t]) translate([main_diameter/2 + swell*sin((h/height)*180),0,0]) {
                            rotate([0,0,-h*8]) regular_polygon(order=7, r=circle_diameter/2 + (4 * sin((1*h/height)*180)));
                        }
                    }

                    regular_polygon(r=main_diameter/2 + 5, order=divs_per_circle);
                    }
                circle(d=40, $fa=1);
                }
            }
        }
    }

