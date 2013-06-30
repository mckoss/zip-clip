module choochoo(width, length, height) {

    // main cube
    translate([0, -width/2, 0])
  	cube([length, width, height]);

    // wheels
	wheel_radius = height/3;
	wheel_width = width/4;
	wheel_buffer = 4/3;
	translate([wheel_radius*wheel_buffer, width-wheel_width, 0])
		rotate(a=[90, 0, 0])
			cylinder(h=wheel_width, r=wheel_radius);
	translate([length-wheel_radius*wheel_buffer, width-wheel_width, 0])
		rotate(a=[90, 0, 0])
			cylinder(h=wheel_width, r=wheel_radius);
	translate([wheel_radius*wheel_buffer, -width/2, 0])
		rotate(a=[90, 0, 0])
			cylinder(h=wheel_width, r=wheel_radius);
	translate([length-wheel_radius*wheel_buffer, -width/2, 0])
		rotate(a=[90, 0, 0])
			cylinder(h=wheel_width, r=wheel_radius);

	// smoke stack
	smoke_stack_radius = length/8;
	translate([length - 2*smoke_stack_radius, 0, height])
		cylinder(h=height/3, r=smoke_stack_radius);

	// cattle catcher
	polyhedron(
		points=[[length, width/2, 0],
				[length, -width/2, 0],
				[length, width/2, height/2],
				[length, -width/2, height/2],
				[length+length/3, 0, 0]],
		triangles=[[0,1,4], [0,2,4], [1,3,4], [2,3,4]]);
	
}

choochoo(length=40, width=15, height=20);
