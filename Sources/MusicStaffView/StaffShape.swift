//
//  StaffShape.swift
//  
//
//  Created by Mike Muszynski on 4/26/22.
//

import Foundation
import CoreGraphics

extension MusicStaffView {
    class func spaceWidth(in rect: CGRect, ledgerLines: Int = 0) -> CGFloat {
        return rect.size.height / (6.0 + CGFloat(ledgerLines))
    }
    
    /// The path to draw. The five lines of the staff plus as many ledger lines as will fit in the view (just don't stop drawing ledger lines until you run out of room).
    ///
    /// - Returns: A CGPath representing the potential lines on the staff
    class func staffPath(in rect: CGRect, spaceWidth: CGFloat? = nil, ledgerLines: Int = 0) -> CGPath {
        let staffLines = CGMutablePath()
        //self.lineWidth = spaceWidth / 10.0
        let spaceWidth = spaceWidth ?? MusicStaffView.spaceWidth(in: rect, ledgerLines: ledgerLines)
        
        //draw ledger lines until there's no more room to do it anymore.
        //they'll get masked out later in the process
        var height = rect.origin.y
        while height <= rect.size.height {
            staffLines.move(to: CGPoint(x: rect.origin.x, y: height))
            staffLines.addLine(to: CGPoint(x: rect.origin.x + rect.size.width, y: height))
            height += spaceWidth
        }
        
        return staffLines
    }
}
