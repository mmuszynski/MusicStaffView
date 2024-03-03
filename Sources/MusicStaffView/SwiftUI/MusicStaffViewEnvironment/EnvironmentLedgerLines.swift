//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

@available(macOS 15, *)
@available(iOS 15.0, *)
struct MaxLedgerLinesKey: EnvironmentKey {
    static var defaultValue: Int = 2
}

@available(macOS 15, *)
@available(iOS 15.0, *)
extension EnvironmentValues {
    var maxLedgerLines: Int {
        get { self[MaxLedgerLinesKey.self] }
        set { self[MaxLedgerLinesKey.self] = newValue }
    }
}

@available(macOS 15, *)
@available(iOS 15.0, *)
struct MaxLedgerLinesKeyModifier: ViewModifier {
    var maxLedgerLines: Int
    func body(content: Content) -> some View {
        content
            .environment(\.maxLedgerLines, maxLedgerLines)
    }
}

@available(macOS 15, *)
@available(iOS 15.0, *)
extension View {
    public func maxLedgerLines(_ num: Int) -> some View {
        modifier(MaxLedgerLinesKeyModifier(maxLedgerLines: num))
    }
}
