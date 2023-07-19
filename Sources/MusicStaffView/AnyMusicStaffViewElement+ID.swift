//
//  File.swift
//  
//
//  Created by Mike Muszynski on 6/21/23.
//

import SwiftUI

extension AnyMusicStaffViewElement: Identifiable {
    var id: UUID {
        return self.uuid
    }
    
    public static func == (lhs: AnyMusicStaffViewElement, rhs: AnyMusicStaffViewElement) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}
