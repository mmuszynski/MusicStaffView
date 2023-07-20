//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/19/23.
//

import SwiftUI
import Music

struct ClefKey: EnvironmentKey {
    static var defaultValue: MusicClef = .treble
}

extension EnvironmentValues {
    var clef: MusicClef {
        get { self[ClefKey.self] }
        set { self[ClefKey.self] = newValue }
    }
}
