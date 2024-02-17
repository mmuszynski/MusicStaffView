//
//  File.swift
//  
//
//  Created by Mike Muszynski on 6/14/23.
//

import Foundation
import Music

@available(macOS 15, *)
@available(iOS 15.0, *)
extension MusicStaffView {
    @MusicStaffViewElementGroupBuilder
    var testElements: [MusicStaffViewElement] {
        MusicClef.bass
        
        MusicPitch.c
            .accidental(.sharp)
            .octave(3)
            .length(.quarter)
    }
}

@resultBuilder
enum MusicStaffViewElementGroupBuilder {
    static func buildBlock(_ components: MusicStaffViewElement...) -> [MusicStaffViewElement] {
        return components
    }
}

extension UIMusicStaffView {
    public convenience init(frame: CGRect, @MusicStaffViewElementGroupBuilder _ elements: () -> [any MusicStaffViewElement]) {
        self.init(frame: frame)
        self.elementArray = elements()
    }
}
