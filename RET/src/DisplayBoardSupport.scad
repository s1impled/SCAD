DisplayHoleX = 3.1;
DisplayHoleY = 2.1;
DisplayStandoff = 2.4;
DisplayBoardThickness = 1.1;

module OvalCylinder(x, y, h) {
    $fn = 180;
    translate([(x-y)/2, 0, 0]) {
        hull () {
            cylinder(d = y, h = h);
            translate([y-x,0,0]) {
                cylinder(d = y, h = h);
            }
        }
    }
}

module OvalCone(x, y, h) {
    $fn = 180;
    translate([(x-y)/2, 0, 0]) {
        hull () {
            cylinder(r1 = y/2, r2 = 0.5, h = h);
            translate([y-x,0,0]) {
                cylinder(r1 = y/2, r2 = 0.5, h = h);
            }
        }
    }
}

module DisplayBoardSupport () {
    union() {
        OvalCylinder(DisplayHoleX+2, DisplayHoleY+2, DisplayStandoff);
        translate([0, 0, DisplayStandoff]) {
            OvalCylinder(DisplayHoleX, DisplayHoleY, DisplayBoardThickness);
            translate([0, 0, DisplayBoardThickness]) {
               OvalCone(DisplayHoleX+0.5, DisplayHoleY+0.5, DisplayBoardThickness); 
            }
        }
    }
}

DisplayBoardSupport();

