//
//  File.swift
//  
//
//  Created by Mike Muszynski on 6/21/23.
//

import SwiftUI

extension AnyMusicStaffViewAccessory: Identifiable {
    var id: UUID {
        return self.uuid
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}
