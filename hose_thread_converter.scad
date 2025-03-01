include <BOSL2/std.scad>
include <BOSL2/threading.scad>

$fn = 64;

module bsp_thread(length, outer, internal) {
	threaded_rod(d=outer, pitch=1.814, l=length, internal=internal);
}

difference() {
	bsp_diameter = 20.955; // Major diameter in mm

	union() {
		difference() {
			cylinder(h=8, d=25, center=true, $fn=8);
			bsp_thread(length=16, outer=bsp_diameter, internal=true);
		}

		translate([0, 0, -4])
			resize([-1,-1,2]) {
				hull() {
					cylinder(h=0.0001, d=25, center=true, $fn=8);
					translate([0, 0, -2])
						cylinder(h=0.0001, d=18.565, center=true);
				}
			}

		translate([0, 0, -10])
				bsp_thread(length=8, outer=bsp_diameter*0.98, internal=false);
	}

	translate([0, 0, -4.98])
		cylinder(h=2, d=7, d2=bsp_diameter, center=true);

	cylinder(h=30, d=7, center=true);
}
