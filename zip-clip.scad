// Zip-Clip - zipper locking device
//
// Startup Weekend Maker Edition - Seattle
// June 29, 2013

// Epsilon - to ensure walls not coincident
E = 0.01;

module zip_clip(length,
                outer_width,
                outer_height,
                inner_height,
                zipper_width,
                groove_depth) {
  inner_width = zipper_width - 2 * groove_depth;

  difference() {
    translate([0, -outer_width / 2, 0])
      cube([length, outer_width, outer_height]);

    translate([-E, -inner_width / 2, -E])
      cube([length + 2 * E, inner_width, inner_height + E]);
  }
}

module grooves(width,
               depth,
               height,
               pitch,
               length) {
  extra = 1;
  steps = ceil(length / pitch) + extra;
  translate([-extra * pitch, 0, 0])
    step_pitch(steps=steps, pitch=pitch)
      groove(width=width, depth=depth, height=height);
}

module groove(width,
              depth,
              height) {
  multmatrix(m=[ [1, 0, 1, 0],
                 [0, 1, 0, 0],
                 [0, 0, 1, 0],
                 [0, 0, 0, 1]
               ])
  linear_extrude(height=height)
    polygon(points=[ [0, 0], [width, 0], [width / 2, depth] ]);
}

module step_pitch(steps, pitch) {
  for (i = [0: steps - 1]) {
    translate([i * pitch, 0, 0])
      child(0);
  }
}

zip_clip(length=20,
         outer_width=10.0,
         outer_height=3.0,
         inner_height=1.5,
         zipper_width=6.92,
         groove_depth=0.5);



grooves(width=10, depth=10, height=50, pitch=15, length=150);