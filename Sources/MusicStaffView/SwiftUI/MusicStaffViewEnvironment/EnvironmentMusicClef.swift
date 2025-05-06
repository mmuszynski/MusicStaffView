//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/19/23.
//

import SwiftUI
import Music

//struct ClefKey: EnvironmentKey {
//    static var defaultValue: MusicClef = .treble
//}
//
//extension EnvironmentValues {
//    var clef: MusicClef {
//        get { self[ClefKey.self] }
//        set { self[ClefKey.self] = newValue }
//    }
//}
//
//struct ClefModifier: ViewModifier {
//    var clef: MusicClef
//    func body(content: Content) -> some View {
//        content
//            .environment(\.clef, clef)
//    }
//}
//
//extension View {
//    func clef(_ clef: MusicClef) -> some View {
//        modifier(ClefModifier(clef: clef))
//    }
//}

extension EnvironmentValues {
    @Entry var clef: MusicClef = .treble
}

extension View {
    func clef(_ clef: MusicClef) -> some View {
        environment(\.clef, clef)
    }
}
