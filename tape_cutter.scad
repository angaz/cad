$fn = 32;

n_discs=9;
disc_gap = 5;
disc_diameter = 45;
disc_thickness = 0.1;
height = (n_discs+1)*disc_gap;

spline_inner = 8;
spline_outer = 10;

carrier_thickness = 2.5;

tollerance = 0.2;

module spline(h) {
		cylinder(h=h, d=spline_inner, center=true);
		translate([0, 0, -h/2]) {
			for (r = [0:120:240]) {
				rotate(r)
					rotate_extrude(angle=60)
						square([spline_outer/2, h]);
			}
		}
}

module disc() {
	difference() {
		cylinder(h=disc_thickness, d=disc_diameter, center=true);
		spline(disc_thickness*2);
	}
}

module spline_shaft() {
	spline(h=height+carrier_thickness);
}

module carrier() {
	t2 = carrier_thickness*2;

	difference() {
		cube([disc_diameter+t2, disc_diameter+5, height+t2], center=true);

		cube([disc_diameter, disc_diameter+10, height], center=true);

		cylinder(h=height+carrier_thickness+tollerance, d=spline_outer+tollerance, center=true);

		translate([0, disc_diameter/4+spline_outer/4, 0])
		cube([spline_outer+tollerance, disc_diameter/2+spline_outer/4, height+carrier_thickness+tollerance], center=true);

		for (i = [0:n_discs-1]) {
			translate([0, 0, -(height/2-disc_gap)+(i*disc_gap)])
				union() {
					cylinder(d=disc_diameter+tollerance, h=disc_thickness+0.15, center=true);
					
					translate([0, disc_diameter/2, 0])
						cube([disc_diameter+tollerance, disc_diameter, disc_thickness+0.15], center=true);
				}
		}
	}
}

module separator() {
	h = disc_gap - disc_thickness;
	difference() {
		cylinder(h=h, d=spline_outer+tollerance+2);
		cylinder(h=h, d=spline_outer+tollerance);
	}
}

spline_shaft();
carrier();
separator();

// Disks for show
%for (i = [0:n_discs-1]) {
	translate([0, 0, -(height/2-disc_gap)+(i*disc_gap)])
		disc();
}
