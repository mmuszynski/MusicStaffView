//
//  MusicStaffViewKeySignature.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

enum ScaleMode {
    case major
    case minor
    
    func description() {
    }
}

class MusicStaffViewKeySignature: MusicStaffViewElement {
    
    var rootNote = MusicPitch(name: .c, accidental: .natural, octave: 0)
    
    init(sharps: UInt, mode: ScaleMode) {
    }
    
    init(flats: UInt, mode: ScaleMode) {
    }
   
}
