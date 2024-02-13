//
//  File.swift
//
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI

struct ForceAccidentalsEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var forceAccidentals: Bool {
        get { self[ForceAccidentalsEnvironmentKey.self] }
        set { self[ForceAccidentalsEnvironmentKey.self] = newValue }
    }
}

