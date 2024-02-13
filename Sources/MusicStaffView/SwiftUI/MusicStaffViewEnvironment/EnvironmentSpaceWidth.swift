//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

struct SpaceWidthKey: EnvironmentKey {
    static var defaultValue: CGFloat = 100
}

extension EnvironmentValues {
    var spaceWidth: CGFloat {
        get { self[SpaceWidthKey.self] }
        set { self[SpaceWidthKey.self] = newValue }
    }
}

struct SpaceWidthModifier: ViewModifier {
    var spaceWidth: CGFloat
    func body(content: Content) -> some View {
        content
            .environment(\.spaceWidth, spaceWidth)
    }
}

extension View {
    func spaceWidth(_ spaceWidth: CGFloat) -> some View {
        modifier(SpaceWidthModifier(spaceWidth: spaceWidth))
    }
}
