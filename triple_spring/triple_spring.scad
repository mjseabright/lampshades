module regular_polygon(order = 5, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

height = 180;
layer_height = 0.2;
main_diameter = 70;
divs_per_circle = 3;
spiral_radius = 6;
circle_radius = 90;
swell = 10;


for (h = [0:layer_height:height]) {
    translate([0,0,h]) rotate([0,0,0]) {
        linear_extrude(layer_height) {
            difference() {
                union() {
                    for (t = [0:360/divs_per_circle:360]) {
                        rotate([0,0,t]) translate([main_diameter/2 + swell*sin((h/height)*180),0,0]) {
                            rotate([0,0,h*8]) translate([spiral_radius,0,0]) regular_polygon(order=120, r=circle_radius/2 + (10 * sin((h/height)*180)));
                        }
                    }
                }
                circle(d=40, $fa=1);
            }
        }
    }
}
