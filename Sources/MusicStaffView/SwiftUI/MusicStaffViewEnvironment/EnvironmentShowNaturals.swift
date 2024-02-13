//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/24/23.
//

import Foundation
import SwiftUI

struct ShowNaturalAccidentalsKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var showNaturalAccidentals: Bool {
        get { self[ShowNaturalAccidentalsKey.self] }
        set { self[ShowNaturalAccidentalsKey.self] = newValue }
    }
}

struct ShowNaturalAccidentalsKeyModifier: ViewModifier {
    var showNaturalAccidentals: Bool
    func body(content: Content) -> some View {
        content
            .environment(\.showNaturalAccidentals, showNaturalAccidentals)
    }
}

extension View {
    func showNaturalAccidentals(_ showNaturalAccidentals: Bool) -> some View {
        modifier(ShowNaturalAccidentalsKeyModifier(showNaturalAccidentals: showNaturalAccidentals))
    }
}
