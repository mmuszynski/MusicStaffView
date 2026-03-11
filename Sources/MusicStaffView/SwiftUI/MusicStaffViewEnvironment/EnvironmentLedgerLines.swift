//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry var maxLedgerLines: Int = 2
}

extension View {
    public func maxLedgerLines(_ maxLedgerLines: Int) -> some View {
        environment(\.maxLedgerLines, maxLedgerLines)
    }
}
