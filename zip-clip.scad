// Zip-Clip - zipper locking device
//
// Startup Weekend Maker Edition - Seattle
// June 29, 2013

use <write.scad>
use <choochoo.scad>

VERSION = "0.4";

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
                type="",
                add_tang=false,
                add_version=true,
                locking=true) {
  inner_width = zipper_width - guage;

  difference() {
    translate([0, -outer_width / 2, 0])
      cube([length, outer_width, outer_height]);

    translate([-E, -inner_width / 2, -E])
      cube([length + 2 * E, inner_width, inner_height + E]);

    translate([-E, -zipper_width / 2, lip])
      cube([length + 2 * E, zipper_width, inner_height - lip]);

  }

  if (add_tang == true) {
    translate([-length / 2 + E, 0, inner_height])
    tang(width=outer_width, length=length / 2, height=outer_height - inner_height);
  }

  if (locking) {
    translate([0, zipper_width / 2 + E, lip])
      ridges(width=guage, depth=guage / 3, height=inner_height - lip, pitch=pitch, length=length);

    mirror([0, 1, 0])
      translate([pitch / 2, zipper_width / 2 + E, lip])
        ridges(width=guage, depth=guage / 3, height=inner_height - lip, pitch=pitch, length=length);
  }

  if (type != "") {
    translate([2, -zipper_width / 2, outer_height])
      write(str(type, add_version ? VERSION: ""), h=zipper_width / 2, t=0.5);
  }
}

module tang(width, length, height) {
  translate([0, -width / 2, 0])
  difference() {
      cube([length, width, height]);
      translate([1, 1, -E])
        cube([length - 4, width - 2, height + 2 * E]);
      translate([-E, width - 2, -E])
        cube([1 + 2 * E, 1 + 2 * E, height + 2 * E]);
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

module loop(thickness, radius) {
  difference() {
    rotate(a=90, v=[1, 0, 0])
    translate([0, radius - thickness / 2, 0])
    rotate_extrude($fn=30)
      translate([radius, 0, 0])
      circle(r=thickness / 2, $fn=30);

    translate([-2 * radius, -thickness, -(thickness + E)])
      cube([2 * radius, 2 * thickness, 2 * thickness]);

    translate([-E, -thickness, -thickness-E])
      cube([2 * radius, 2 * thickness, thickness]);
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

module ribbon(length=15) {
  zip_clip(length=length,
           outer_width=7.68,
           outer_height=2.80,
           inner_height=1.8,
           zipper_width=5.68,
           guage=1.0,
           pitch=2.2,
           lip=0.50,
           add_tang=true,
           type="R");
}

module toy(length=20) {
  zip_clip(length=length,
           outer_width=9.0,
           outer_height=3.70,
           inner_height=2.70,
           zipper_width=7.13,
           guage=1.00,
           pitch=1.70,
           lip=0.50,
           locking=false,
           type="");
  translate([0, 0, 3.7 - E])
    choochoo(length=length, width=9.0, height=8);
}

module bag(length=20) {
  zip_clip(length=length,
           outer_width=7.81,
           outer_height=3.60,
           inner_height=2.6,
           zipper_width=6.31,
           guage=1.0,
           pitch=1.53,
           lip=0.50,
           type="ZipSnap",
           add_version=false);
}

module dress(length=30) {
  zip_clip(length=length,
           outer_width=7.9,
           outer_height=4.4,
           inner_height=2.9,
           zipper_width=5.9,
           guage=1.1,
           pitch=2.3,
           lip=0.50,
           add_tang=true,
           type="Michael Koss",
           add_version=false);
}

module cable(length=20) {
  zip_clip(length=length,
           outer_width=8.23,
           outer_height=3.70,
           inner_height=2.70,
           zipper_width=6.23,
           guage=1.00,
           pitch=1.70,
           lip=0.50,
           locking=false,
           type="ZipSnap",
           add_version=false);
  translate([length / 2, 0, 3.7])
    rotate(a=90, v=[0, 0, 1])
      loop(2.5, 4);
}

model_name = "toy";

if (model_name == "luggage") luggage();
if (model_name == "dryer") dryer();
if (model_name == "backpack") backpack();
if (model_name == "cable") cable();
if (model_name == "toy") toy();
if (model_name == "bag") bag();
if (model_name == "dress") dress();
