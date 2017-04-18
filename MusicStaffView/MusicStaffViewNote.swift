//
//  MusicStaffViewNote.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

public func +(lhs: MusicStaffViewNote, rhs: Int) -> MusicStaffViewNote {
    return lhs
}

public class MusicStaffViewNote: MusicStaffViewElement {
    
    public var note: MusicNote
    public var length : MusicNoteLength = .quarter

    public var name: MusicPitchName {
        return note.name
    }
    public var octave: Int {
        return note.octave
    }
    public var accidental: MusicPitchAccidental {
        return note.accidental
    }
    
    public required init(note: MusicNote) {
        self.note = note
    }
    
    
    
}
