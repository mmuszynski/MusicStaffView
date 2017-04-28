//
//  MusicKeySignaturePitch+Element.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/26/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicKeySignaturePitch: MusicStaffViewAccessory {
    public var placement: MusicStaffViewAccessoryPlacement {
        return .standalone
    }
    
    public var anchorPoint: CGPoint {
        return self.accidental.anchorPoint
    }
    
    public var aspectRatio: CGFloat {
        return self.accidental.aspectRatio
    }
    
    public func path(in frame: CGRect) -> CGPath {
        return self.accidental.path(in: frame)
    }
    
    public var heightInStaffSpace: CGFloat {
        return self.accidental.heightInStaffSpace
    }
    
    public func requiresLedgerLines(in clef: MusicClef) -> Bool {
        return false
    }
    
    public func offset(in clef: MusicClef) -> Int {
        var pitch = MusicPitch(name: self.name, accidental: self.accidental, octave: 0)
        var note = MusicNote(pitch: pitch, rhythm: .quarter)
        let octave = try! MusicInterval(direction: .upward, quality: .perfect, quantity: .octave)
        
        let range: ClosedRange<Int>
        switch clef {
        case .gClef(_):
            if accidental == .sharp {
                range = -5...1
            } else {
                range = -3...3
            }
        case .cClef(let offset):
            if offset == 0 {
                if accidental == .sharp {
                    range = -4...2
                } else {
                    range = -2...4
                }
            } else {
                if accidental == .sharp {
                    range = -4...2
                } else {
                    range = -4...2
                }
            }
        default:
            if accidental == .sharp {
                range = -3...3
            } else {
                range = -1...5
            }
        }
        
        while !range.contains(note.offset(in: clef)) {
            pitch = try! octave.destinationPitch(from: pitch)
            note.pitch = pitch
        }
        
        return note.offset(in: clef)
    }
}
