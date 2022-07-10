module regular_polygon(order = 3, r = 1) {
     angles = [ for (i = [0:order-1]) i * (360 / order) ];
     coords = [ for (th = angles) [r * cos(th), r * sin(th)] ];
     polygon(coords);
}

function regular_polygon_side_length(order = 3, r = 1) = 2 * r * sin(360 / (2 * order));
function regular_polygon_radius_from_side_length(order = 3, side_length = 10) = side_length / (2 * sin(360 / (2 * order)));

height = 180;
layer_height = 0.2;
main_diameter = 130;
num_angle_divs = 40;

for (h = [0:layer_height:height]) {
    layer_diameter = main_diameter + 40 * sin((h / height) * 180);
    triangle_ratio = ((h / 10) % 4 >= 2) ? (h / 10) % 2 : 2 - ((h / 10) % 2);

    translate([0,0,h]) linear_extrude (layer_height) intersection() {
        circle(d = layer_diameter + 0 + (12 * sin((h / height) * 180)), $fn=180);
        union() {
            for (theta = [0 : 2 * 360 / num_angle_divs : 360]) {
                triangle_side_length = triangle_ratio * layer_diameter * cos(((num_angle_divs - 2) * 180) / (2 * num_angle_divs));
                triangle_radius = regular_polygon_radius_from_side_length(order = 3, side_length = triangle_side_length);
                triangle_position_offset = sqrt((layer_diameter / 2)^2 - (triangle_side_length / 2)^2);

                rotate([0,0,theta]) translate([triangle_position_offset + triangle_radius * sin(30), 0, 0]) regular_polygon(order = 3, r = triangle_radius);
            }

            for (theta = [0 : 2 * 360 / num_angle_divs : 360]) {
                triangle_side_length = (2 - triangle_ratio) * layer_diameter * cos(((num_angle_divs - 2) * 180) / (2 * num_angle_divs));
                triangle_radius = regular_polygon_radius_from_side_length(order = 3, side_length = triangle_side_length);
                triangle_position_offset = sqrt((layer_diameter / 2)^2 - (triangle_side_length / 2)^2);

                rotate([0,0,theta + 360 / num_angle_divs]) translate([triangle_position_offset + triangle_radius * sin(30), 0, 0]) regular_polygon(order = 3, r = triangle_radius);
            }
            difference() {
                circle(d = layer_diameter + 0.5, $fn=180);
                circle(d = 40, $fn=180);
            }
        }
    }
}
