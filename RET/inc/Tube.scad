/*************************************************
 * Tube (VET)
 * Author: Robert L. Miller
 * Date: 2017-01-22
 * Revision: 001A
 * Provides: Tube
 * Parameter: height - the height/length of tube
 * Parameter: id - the inner diameter
 * Parameter: od - the outer diameter
 ************************************************/
 
 module Tube( height, id, od, center = false ) {
     difference() {
         cylinder( h = height, d = od, center = center );
         translate( [0, 0, -0.001] ) {
             cylinder( h = height + 0.002, d = id, center = center );
         }
     }
 }
 
$fn = 180;
 
 Tube( height = 10, id = 5, od = 10 );