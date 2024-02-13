//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/23/23.
//

import Foundation
import SwiftUI
import Music

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicStaffViewElement {
    var leadingAccessories: [AnyMusicStaffViewElement] {
        self
        .accessoryElements
        .filter { $0.placement == .leading }
        .map { AnyMusicStaffViewElement($0) }
    }
    
    public var body: some View {
        return HStack(spacing: 0) {
            ForEach(leadingAccessories) { accessory in
                MusicStaffViewElementShapeView(parent: self, element: accessory)
            }
            MusicStaffViewElementShapeView(element: self)
        }
    }
}

struct ElementPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                MusicClef.bass
                MusicClef.treble
                MusicClef.alto
                MusicClef.tenor
            }
            .previewDisplayName("Clefs")
            
            HStack {
                MusicAccidental.sharp
                MusicAccidental.flat
            }
            .previewDisplayName("Accidentals")
            
            HStack {
                MusicPitch.c
                    .octave(5)
                    .length(.quarter)
                MusicPitch.b
                    .octave(4)
                    .length(.half)
                MusicPitch.c.length(.whole)
                Group {
                    MusicPitch.c.length(.quarter)
                    MusicPitch.c.length(.half)
                    MusicPitch.c.length(.whole)
                }
            }
            .previewDisplayName("Notes")
            
            HStack {
                MusicPitch.d
                    .octave(4)
                    .accidental(.natural)
                    .length(.quarter)
                MusicPitch.d
                    .octave(4)
                    .accidental(.natural)
                    .length(.half)
                MusicPitch.d
                    .octave(4)
                    .accidental(.natural)
                    .length(.whole)
            }
            .clef(.treble)
        }
        .previewLayout(.fixed(width: 400, height: 100))
        .spaceWidth(10)
    }
}

