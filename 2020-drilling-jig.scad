$fn = 32;

outer_size = 24;
drill_size = 5;

module profile_2020(h) {
    translate([-10, -10, -h/2])          // center=true
        linear_extrude(h)
            offset(delta=0.1)        // 0.1mm clearance
                resize([20, 20, 0])  // Should be noop, but make sure it's exactly 20mm
                    import("2020-profile.dxf");
}

difference() {
    height = 21;

    // Rounded cube
    translate([0, 0, -11])
        linear_extrude(height)
            offset(r=1) offset(delta=-1)
                square([outer_size, outer_size], center=true);

    // Profile negative
    translate([0, 0, 0])
        profile_2020(20);

    // Top hole
    cylinder(h=outer_size, d=8, center=true);

    // Side holes
    rotate([0, 90, 0])
        cylinder(h=outer_size, d=drill_size, center=true);
    rotate([90, 90, 0])
        cylinder(h=outer_size, d=drill_size, center=true);
}
