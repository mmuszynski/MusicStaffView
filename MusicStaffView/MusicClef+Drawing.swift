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
    ///Computes the pitch for the center line.
    ///
    ///Useful for drawing pitches, as they are offset from the center line a number of places.
    ///
    ///- important: The offset for the clef is opposite the direction of the offset of each note. For example, the treble clef reference pitch is offset two places down from the center line (G4), so the center line pitch is offset two places up from this reference (B4).
    public var centerLinePitch: MusicPitch {
        let clefOffset: Int
        
        switch self {
        case .cClef(let offset), .fClef(let offset), .gClef(let offset):
            clefOffset = offset
        }
        
        return MusicClef.pitch(from: self.referencePitch, offset: -clefOffset)
    }
    
    ///Calculates a pitch that is offset by a number of staff places from another pitch
    static func pitch(from referencePitch: MusicPitch, offset: Int, accidental: MusicPitchAccidental = .none) -> MusicPitch {
        //change the offset such that it is relative to the C in this octave
        let clefOffsetFromOctaveC = referencePitch.name.rawValue
        let cOffset = offset + clefOffsetFromOctaveC
        
        //come up with the appropriate, relative octave
        let relativeOctave = cOffset >= 0 ? cOffset / 7 : (cOffset + 1) / 7 - 1
        
        //come up with the relative offset caused by the note
        let noteOffset = cOffset % 7
        let absoluteOffset = noteOffset < 0 ? 7 + noteOffset : noteOffset
        let newPitchName = MusicPitchName(rawValue: absoluteOffset)!
        let newOct = referencePitch.octave + relativeOctave
        
        return MusicPitch(name: newPitchName, accidental: accidental, octave: newOct)
    }
    
    ///Calculates a pitch that is offset by a number of staff places from the `centerLinePitch` for this clef.
    func pitch(forOffset offset: Int, accidental: MusicPitchAccidental = .none) -> MusicPitch {
        return MusicClef.pitch(from: self.centerLinePitch, offset: offset, accidental: accidental)
    }
    
    ///Calculates the offset for a pitch the current clef
    ///
    ///Since notes need to be draw in the correct place in the y-axis, the offset from a given starting location must be computed. Currently, the zero-offset corresponds to the note one ledger line below the lowest staff line (aka Middle C in Treble Clef).
    ///
    ///The offset for the note specifies an offset from the center of the view, which also represents the center of the staff.
    ///
    ///- parameter name: The name of the note
    ///- parameter octave: The octave of the note
    public func offsetForPitch(named name: MusicPitchName, octave: Int) -> Int {
        let reference = self.centerLinePitch
        let offset = reference.relativeOffset(for: name, octave: octave)
        return -offset
    }
    
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
