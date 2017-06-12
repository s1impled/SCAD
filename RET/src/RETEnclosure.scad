// Units in mm

use <../inc/Tube.scad>

RPIBoardWidth = 56;
RPIBoardLength = 85;
RPIBoardHeight = 30;

RPIMountWidth = 48;
RPIMountLength = 57;

RPIMountScrewDiameter = 2;
RPIMountScrewStandoffHeight = 10;

RelayBoardWidth = 23;
RelayBoardLength = 43;
RelayBoardHeight = 22;

RelayMountWidth = 15;

RPIEnclosureWallThickness = 1.5;

USBPortWidth = 15;
USBPortHeight = 10;

module ScrewStand(screwDiameter, height) {
    $fn = 180;
    od = screwDiameter / 0.5;
    union() {
        difference() {
            cylinder(r1=od, r2=od/2, h=height/3);
            translate([0, 0, -0.1]) {
                cylinder(d=od, h=height);
            }
        }
        Tube(height, screwDiameter - 0.1, od);
        translate([0, 0, -RPIEnclosureWallThickness]) {
            cylinder(r=od, h=RPIEnclosureWallThickness);
        }
    }
}

module RPIMounts() {
    for( x =[0:RPIMountWidth:RPIMountWidth], y = [0:RPIMountLength:RPIMountLength] ) {
        translate([x, y, 0]) {
            ScrewStand(RPIMountScrewDiameter, RPIMountScrewStandoffHeight);
        }
    }
    translate([(RPIMountWidth - RPIBoardWidth - 5) / 2, -RPIMountScrewDiameter / 0.5, -RPIEnclosureWallThickness]) {
        cube([RPIBoardWidth + 5, RPIMountScrewDiameter / 0.25, RPIEnclosureWallThickness]);
        translate([0, RPIMountLength , 0]) {
            cube([RPIBoardWidth + 5, RPIMountScrewDiameter / 0.25, RPIEnclosureWallThickness]);
        }
    }
}

module RelayMounts() {
    for ( y = [0:RelayMountWidth:RelayMountWidth] ){
        translate([0, y, 0]) {
            ScrewStand(RPIMountScrewDiameter, RPIMountScrewStandoffHeight);
        }
    }
}

module RPIBase() {
    $fn = 180;
    BaseWidth = RPIBoardWidth + 30;
    BaseLength = RPIBoardLength + RelayBoardWidth + 2;
    echo (BaseLength);
    RelayMountX = BaseWidth - (BaseWidth - RelayBoardLength) / 2 - 2.5;
    RelayMountY = BaseLength - RelayBoardWidth / 2 - RelayMountWidth / 2 - 2.5;
    RelayStandX = RelayMountX - RelayBoardLength + 5;
    RelayStandY = RelayMountY + RelayMountWidth / 2;
    
    union() {
        difference() {
            cube([BaseWidth, BaseLength, RPIEnclosureWallThickness]);
            for (x = [0:6:RPIBoardWidth]) {
                translate([x + 20, 3, -0.1]) {
                    cube([2.5, RPIBoardLength-3, RPIEnclosureWallThickness+1]);
                }
            }
        }
            
        translate([0, 0, RPIEnclosureWallThickness]) {
            translate([BaseWidth - RPIMountWidth - 13, 26, 0]) {
                RPIMounts();
            }            

            translate([RelayMountX, RelayMountY, 0]) {
                RelayMounts();
            }
            
            translate([RelayStandX, RelayStandY, 0]) {
                ScrewStand(RPIMountScrewDiameter, RPIMountScrewStandoffHeight);
            }

            difference() {
                cube([RPIEnclosureWallThickness, BaseLength, RPIBoardHeight]);
                translate([-0.1, RPIBoardLength - 15 - USBPortWidth, RPIMountScrewStandoffHeight])
                cube([RPIEnclosureWallThickness + 0.2, USBPortWidth, USBPortHeight]);
            }
            
            difference() {            
                cube([BaseWidth, RPIEnclosureWallThickness, RPIBoardHeight]);
                translate([20, -0.1, RPIMountScrewStandoffHeight]) {
                    cube([RPIBoardWidth, RPIEnclosureWallThickness+0.2, 17]);
                }
            }
            
            translate([BaseWidth - RPIEnclosureWallThickness, 0, 0]) {
                cube([RPIEnclosureWallThickness, BaseLength, RPIBoardHeight]);
            }
            translate([0, BaseLength - RPIEnclosureWallThickness, 0]) {
                cube([BaseWidth, RPIEnclosureWallThickness, RPIBoardHeight]);
            }
            
            for( x = [RPIEnclosureWallThickness * 2 : BaseWidth - RPIEnclosureWallThickness  * 4: BaseWidth], 
                y = [RPIEnclosureWallThickness * 2: BaseLength - RPIEnclosureWallThickness * 4 : BaseLength]) {
                translate([x, y, 0]) {
                    difference() {
                        cylinder(r=RPIEnclosureWallThickness * 2, h = RPIBoardHeight);
                        translate([0, 0, RPIBoardHeight * 0.75 + 0.0001]) {
                            cylinder(d=RPIMountScrewDiameter, h=RPIBoardHeight/4);
                        }
                    }
                }
            }
        }
    }
}

RPIBase();