//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

//struct ElementOffsetKey: EnvironmentKey {
//    static var defaultValue: Int? = nil
//}
//
//extension EnvironmentValues {
//    var elementOffset: Int? {
//        get { self[ElementOffsetKey.self] }
//        set { self[ElementOffsetKey.self] = newValue }
//    }
//}
//
//struct ElementOffsetModifier: ViewModifier {
//    var elementOffset: Int?
//    func body(content: Content) -> some View {
//        content
//            .environment(\.elementOffset, elementOffset)
//    }
//}
//
//extension View {
//    func elementOffset(_ elementOffset: Int?) -> some View {
//        modifier(ElementOffsetModifier(elementOffset: elementOffset))
//    }
//}

extension EnvironmentValues {
    @Entry var elementOffset: Int? = nil
}
