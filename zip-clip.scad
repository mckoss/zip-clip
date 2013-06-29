// Zip-Clip - zipper locking device
//
// Startup Weekend Maker Edition - Seattle
// June 29, 2013

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

    translate([-1, -inner_width / 2, -1])
      cube([length + 2, inner_width, inner_height + 1]);
  }
}

zip_clip(length=20,
         outer_width=10.0,
         outer_height=3.0,
         inner_height=1.5,
         zipper_width=6.92,
         groove_depth=0.5);
