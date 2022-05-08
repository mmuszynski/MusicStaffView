//
//  File.swift
//  
//
//  Created by Mike Muszynski on 4/28/22.
//

import SwiftUI

@available(macOS 12, *)
@available(iOS 13, *)
struct StaffShape: Shape {
    var spaceWidth: CGFloat = 10
    var lineWidth: CGFloat { spaceWidth / 10 }
    var ledgerLines: Int
    func path(in rect: CGRect) -> Path {
        Path(MusicStaffView.staffPath(in: rect, spaceWidth: self.spaceWidth, ledgerLines: self.ledgerLines))
    }
    
    static func staffMask(withSpaceWidth spaceWidth: CGFloat, lineWidth: CGFloat? = nil) -> some View {
        let lineWidth = lineWidth ?? spaceWidth / 10
        return Rectangle()
            .frame(height: spaceWidth * 4 + lineWidth)
    }
}
