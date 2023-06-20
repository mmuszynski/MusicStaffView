//
//  File.swift
//  
//
//  Created by Mike Muszynski on 6/14/23.
//

import Foundation
import Music

extension MusicStaffView {
    @MusicStaffViewBuilder
    var testElements: [MusicStaffViewElement] {
        MusicClef.bass
        
        MusicPitch.c
            .accidental(.sharp)
            .octave(3)
            .length(.quarter)
    }
}

@resultBuilder
enum MusicStaffViewBuilder {
    static func buildBlock(_ components: MusicStaffViewElement...) -> [MusicStaffViewElement] {
        return components
    }
}
