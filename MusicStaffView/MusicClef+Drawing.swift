//
//  MusicClef+Drawing.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/19/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicClef {    
    ///The number of ledger lines necessary for a note at a given staff offset.
    ///
    ///When a note is far enough from the center line of the staff, it will be necessary to draw ledger lines to represent how much outside the staff it lays.
    ///
    ///- parameter offset: The number of positions above or below the middle line where the note resides
    ///
    ///- returns: A tuple with the number of ledger lines and a boolean representing whether or not they are centered on the notehead
    func ledgerLinesForStaffOffset(_ offset: Int) -> (count: Int, centered: Bool) {
        if abs(offset) < 6 {
            return (0, false)
        }
        
        return ((abs(offset) - 4) / 2, offset % 2 == 0)
    }
}
