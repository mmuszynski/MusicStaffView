//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

@available(macOS 12, *)
@available(iOS 15.0, *)
struct SpacingKey: EnvironmentKey {
    static var defaultValue: MusicStaffView.Spacing = .uniformLeadingAndTrailingSpace
}

@available(macOS 12, *)
@available(iOS 15.0, *)
extension EnvironmentValues {
    var spacingType: MusicStaffView.Spacing {
        get { self[SpacingKey.self] }
        set { self[SpacingKey.self] = newValue }
    }
}

@available(macOS 12, *)
@available(iOS 15.0, *)
struct SpacingKeyModifier: ViewModifier {
    var spacingType: MusicStaffView.Spacing
    func body(content: Content) -> some View {
        content
            .environment(\.spacingType, spacingType)
    }
}

@available(macOS 12, *)
@available(iOS 15.0, *)
extension View {
    public func spacing(_ spacing: MusicStaffView.Spacing) -> some View {
        modifier(SpacingKeyModifier(spacingType: spacing))
    }
}
