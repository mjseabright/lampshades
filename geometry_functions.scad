module regular_polygon(order = 5, r=1){
     angles=[ for (i = [0:order-1]) i*(360/order) ];
     coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
     polygon(coords);
 }

function regular_polygon_side_length(order = 3, r = 1) = 2 * r * sin(360 / (2 * order));
function regular_polygon_radius_from_side_length(order = 3, side_length = 10) = side_length / (2 * sin(360 / (2 * order)));
