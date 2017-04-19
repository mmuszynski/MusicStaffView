//
//  MusicStaffViewNote.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit
import Music

extension MusicNote: MusicStaffViewElement {
    public var type: MusicStaffViewElementType {
        return MusicStaffViewElementType.note(self.pitch, self.rhythm)
    }

    public var name: MusicPitchName {
        return pitch.name
    }
    public var octave: Int {
        return pitch.octave
    }
    public var accidental: MusicPitchAccidental {
        return pitch.accidental
    }
    
}
