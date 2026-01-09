//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    @Entry public var debug: Bool = false
}

extension View {
    public func debug(_ debug: Bool = true) -> some View {
        environment(\.debug, debug)
    }
}
