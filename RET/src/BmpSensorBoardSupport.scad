BmpSensorMountHoleDiameter = 3.2;
BmpSensorBoardThickness = 1.7;
BmpSensorHeight = 5;

module BoardSupport(diameter, height) {
    $fn = 180;
    union() {
        cylinder(d = diameter + 2, h = height);
        translate([0, 0, height]) {
            cylinder(d = diameter, h = BmpSensorBoardThickness);
            translate([0, 0, BmpSensorBoardThickness]) {
                cylinder(r1 = (diameter / 2) + 0.3, r2 = 0.5, h = height/2);
            }
        }
    }
}

BoardSupport(BmpSensorMountHoleDiameter, BmpSensorHeight);