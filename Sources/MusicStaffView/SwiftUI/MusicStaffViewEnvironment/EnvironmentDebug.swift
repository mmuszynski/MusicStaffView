//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

//struct DebugEnviornmentKey: EnvironmentKey {
//    static var defaultValue: Bool = false
//}
//
//extension EnvironmentValues {
//    var debug: Bool {
//        get { self[DebugEnviornmentKey.self] }
//        set { self[DebugEnviornmentKey.self] = newValue }
//    }
//}
//
//struct DebugModifier: ViewModifier {
//    var debug: Bool
//    func body(content: Content) -> some View {
//        content
//            .environment(\.debug, debug)
//    }
//}
//
//extension View {
//    func debug(_ debug: Bool) -> some View {
//        modifier(DebugModifier(debug: debug))
//    }
//}

extension EnvironmentValues {
    @Entry var debug: Bool = false
}
