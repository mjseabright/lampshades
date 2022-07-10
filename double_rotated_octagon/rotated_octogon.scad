module regular_polygon(order = 5, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }
 
height = 180;
layer_height = 0.2;
main_radius = 70;
 
difference() {
    union() {
        for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,(a/height) * 2 * 180 / 2]){
                linear_extrude(layer_height) {
                    regular_polygon(order=8, r=main_radius + 30*sin((a/height)*180));
                }
            }
        }

        rotate([0,0,360/16]) for (a = [0:layer_height:height]) {
            translate([0,0,a]) rotate([0,0,-(a/height) * 2 * 180 / 2]){
                linear_extrude(layer_height) {
                    regular_polygon(order=8, r=main_radius + 30*sin((a/height)*180));
                }
            }
        }
    }

    translate([0,0,-10]) linear_extrude(200) circle(d=40, $fa=1);
}
