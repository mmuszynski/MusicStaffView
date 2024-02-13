//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/24/23.
//

import Foundation
import Music
import SwiftUI

struct MusicStaffViewHGroup: MusicStaffViewElement {
    var elements: [any MusicStaffViewElement]
    var anyElements: [AnyMusicStaffViewElement] {
        elements.map { AnyMusicStaffViewElement($0) }
    }
    
    init(@MusicStaffViewElementGroupBuilder _ elements: () -> [MusicStaffViewElement] ) {
        self.elements = elements()
    }
    
    func path(in frame: CGRect) -> CGPath {
        fatalError()
    }
    
    var aspectRatio: CGFloat {
        fatalError()
    }
    
    var heightInStaffSpace: CGFloat {
        fatalError()
    }
    
    var body: some View {
        HStack {
            ForEach(anyElements) { element in
                element.body
            }
        }
    }
}

extension MusicStaffViewHGroup: View {}

#Preview {
    MusicStaffViewHGroup {
        MusicAccidental.sharp
        MusicPitch.c.octave(5).length(.quarter)
        MusicAccidental.sharp
    }
    .spaceWidth(100)
}
