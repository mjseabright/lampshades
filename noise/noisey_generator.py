import math
import numpy as np
import random

main_diameter = 130
diameter_swell = 60
divisions_per_circle = 12
height = 180
height_steps = 45
noise_sd = 0

# Bulbus very low poly
# main_diameter = 100
# diameter_swell = 100
# divisions_per_circle = 6
# height = 180
# height_steps = 90
# noise_sd = 0

# Bulbus quite low poly
# main_diameter = 130
# diameter_swell = 60
# divisions_per_circle = 12
# height = 180
# height_steps = 45
# noise_sd = 0

# High freq noise concave
# main_diameter = 140
# diameter_swell = -20
# divisions_per_circle = 68
# height = 180
# height_steps = 6
# noise_sd = 1.2

# Low freq noise
# main_diameter = 160
# diameter_swell = 40
# divisions_per_circle = 32
# height = 180
# height_steps = 15
# noise_sd = 2.5

# High freq noise
# main_diameter = 150
# diameter_swell = 40
# divisions_per_circle = 96
# height = 180
# height_steps = 5
# noise_sd = 1

# Bulbus low poly Bre
# main_diameter = 100
# diameter_swell = 100
# divisions_per_circle = 24
# height = 180
# height_steps = 20
# noise_sd = 0

def polar_to_cart(r, theta):
	x = r * math.cos(theta)
	y = r * math.sin(theta)
	return (x, y)

def main():
	points = []
	for height_index in range(math.floor((height + height_steps) / height_steps)):
		z = float(height_index * height_steps)
		layer_diameter = main_diameter + diameter_swell * math.sin((math.radians(z / height)) * 180)
		theta_offset = 0
		if height_index % 2:
			theta_offset = 0.5 * (math.pi * 2) / divisions_per_circle
		for angle_index in range(divisions_per_circle):
			theta = angle_index * (math.pi * 2) / divisions_per_circle + theta_offset
			xy = polar_to_cart((layer_diameter / 2) + random.gauss(0, noise_sd), theta)
			x = round(xy[0], 4)
			y = round(xy[1], 4)
			points.append([x, y, z])

	faces = []
	for ring in range(math.floor((height + height_steps) / height_steps) - 1):
		if ring % 2:
			for division in range(divisions_per_circle):
				a = (ring * divisions_per_circle) + (division - 1)  % divisions_per_circle
				b = (ring * divisions_per_circle) + (division) % divisions_per_circle
				c = (ring * divisions_per_circle) + division + divisions_per_circle
				faces.append([a,c,b])
				a = (ring * divisions_per_circle) + division
				b = (ring * divisions_per_circle) + division + divisions_per_circle
				c = (ring * divisions_per_circle) + (division + divisions_per_circle + 1) % (divisions_per_circle * 2)
				if division == divisions_per_circle - 1:
					c = c + divisions_per_circle
				faces.append([a,b,c])
		else:
			for division in range(divisions_per_circle):
				a = (ring * divisions_per_circle) + division
				b = (ring * divisions_per_circle) + (division + 1) % divisions_per_circle
				c = (ring * divisions_per_circle) + division + divisions_per_circle
				faces.append([a,c,b])
				a = (ring * divisions_per_circle) + division + 1
				b = (ring * divisions_per_circle) + division + divisions_per_circle
				c = (ring * divisions_per_circle) + (division + divisions_per_circle + 1) % (divisions_per_circle * 2)
				if division == divisions_per_circle - 1:
					d = b
					b = c
					c = d
				faces.append([a,b,c])

	points.append([0,0,0])
	points.append([0,0,height])
	for division in range(divisions_per_circle):
		faces.append([division, (division + 1) % divisions_per_circle, len(points) - 2])
		faces.append([(division + 1) % divisions_per_circle + divisions_per_circle * (height / height_steps), division + divisions_per_circle * (height / height_steps), len(points) - 1])

	print('', file=open('noisey.scad', 'w'))
	f = open('noisey.scad', 'a')
	print('CylinderPoints =', points, ';', file=f)
	print('CylinderFaces =', faces, ';', file=f)
	print('difference() {\n    polyhedron( CylinderPoints, CylinderFaces, convexity = 10);\n    translate([0,0,-10]) linear_extrude(200) circle(d=40, $fa=1);\n}', file=f)

	f.close()


if __name__ == '__main__':
	main()
