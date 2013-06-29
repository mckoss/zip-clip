// Zip-Clip - zipper locking device
//
// Startup Weekend Maker Edition - Seattle
// June 29, 2013

use <write.scad>

VERSION = "0.3";

// Epsilon - to ensure walls not coincident
E = 0.01;

module zip_clip(length,
                outer_width,
                outer_height,
                inner_height,
                zipper_width,
                guage,
                pitch,
                lip,
                type="") {
  inner_width = zipper_width - guage;

  difference() {
    translate([0, -outer_width / 2, 0])
      cube([length, outer_width, outer_height]);

    translate([-E, -inner_width / 2, -E])
      cube([length + 2 * E, inner_width, inner_height + E]);

    translate([-E, -zipper_width / 2, lip])
      cube([length + 2 * E, zipper_width, inner_height - lip]);

  }

  translate([0, zipper_width / 2 + E, lip])
    ridges(width=guage, depth=guage / 3, height=inner_height - lip, pitch=pitch, length=length);

  mirror([0, 1, 0])
    translate([pitch / 2, zipper_width / 2 + E, lip])
      ridges(width=guage, depth=guage / 3, height=inner_height - lip, pitch=pitch, length=length);

  translate([2, -zipper_width / 2, outer_height])
    write(str(type, VERSION), h=zipper_width / 2, t=0.5);
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

module ridges(width,
              depth,
              height,
              pitch,
              length) {
  steps = ceil(length / pitch);
  step_pitch(steps=steps - 2, pitch=pitch)
    ridge(width=width, depth=depth, height=height);
}

module ridge(width,
              depth,
              height) {
  multmatrix(m=[ [1, 0, 1, 0],
                 [0, 1, 0, 0],
                 [0, 0, 1, 0],
                 [0, 0, 0, 1]
               ])
  linear_extrude(height=height)
    polygon(points=[ [0, 0], [width, 0], [width / 2, -depth] ]);
}

module step_pitch(steps, pitch) {
  for (i = [0: steps - 1]) {
    translate([i * pitch, 0, 0])
      child(0);
  }
}

module luggage(length=15) {
  zip_clip(length=length,
           outer_width=9.0,
           outer_height=2.0,
           inner_height=1.5,
           zipper_width=6.92,
           guage=1.00,
           pitch=1.68,
           lip=0.25,
           type="L");
}

module dryer(length=15) {
  zip_clip(length=length,
           outer_width=8.0,
           outer_height=2.0,
           inner_height=1.62,
           zipper_width=5.86,
           guage=0.97,
           pitch=1.57,
           lip=0.25,
           type="D");
}

module backpack(length=20) {
  zip_clip(length=length,
           outer_width=9.0,
           outer_height=3.70,
           inner_height=2.70,
           zipper_width=7.13,
           guage=1.00,
           pitch=1.70,
           lip=0.50,
           type="B");
}

module ribbon(length=20) {
  zip_clip(length=length,
           outer_width=7.5,
           outer_height=3.70,
           inner_height=2.70,
           zipper_width=5.88,
           guage=1.0,
           pitch=3.56,
           lip=0.50,
           type="R");
}

//luggage();
//dryer();
backpack();
//ribbon();
