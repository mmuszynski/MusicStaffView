//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

//struct LineWidthKey: EnvironmentKey {
//    static var defaultValue: CGFloat = 10
//}
//
//extension EnvironmentValues {
//    var lineWidth: CGFloat {
//        get { self[LineWidthKey.self] }
//        set { self[LineWidthKey.self] = newValue }
//    }
//}
//
//struct LineWidthModifier: ViewModifier {
//    var lineWidth: CGFloat
//    func body(content: Content) -> some View {
//        content
//            .environment(\.lineWidth, lineWidth)
//    }
//}
//
//extension View {
//    public func lineWidth(_ lineWidth: CGFloat) -> some View {
//        modifier(LineWidthModifier(lineWidth: lineWidth))
//    }
//}

extension EnvironmentValues {
    @Entry var lineWidth: CGFloat = 10
}

extension View {
    func lineWidth(_ lineWidth: CGFloat) -> some View {
        environment(\.lineWidth, lineWidth)
    }
}
