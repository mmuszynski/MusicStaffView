//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

@available(iOS 15.0, macOS 14.0, tvOS 15.0, *)
extension EnvironmentValues {
    @available(*, unavailable, renamed: "staffViewElementSpacing")
    var spacingType: MusicStaffView.Spacing { fatalError() }
    @Entry var staffViewElementSpacing: MusicStaffView.Spacing = .uniformLeadingAndTrailingSpace
}

@available(iOS 15.0, macOS 14.0, tvOS 15.0, *)
extension View {
    public func spacing(_ staffViewElementSpacing: MusicStaffView.Spacing) -> some View {
        environment(\.staffViewElementSpacing, staffViewElementSpacing)
    }
}
