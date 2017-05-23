//
//  MusicStaffViewStaffLayer.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

class MusicStaffViewStaffLayer: CAShapeLayer {
    
    /// The maximum number of ledger lines to be drawn. This is controlled by the `MusicStaffView` instance and is not called directly.
    var maxLedgerLines : Int = 0
    
    /// The path described by the staff lines.
    override var path : CGPath! {
        get {
            return staffPath()
        }
        set {
            
        }
    }
    
    /// The width of the spaces between the lines
    var spaceWidth: CGFloat {
        return self.bounds.size.height / (6.0 + 2.0 * CGFloat(maxLedgerLines))
    }
    
    override var lineWidth: CGFloat {
        get {
            return spaceWidth / 10.0
        }
        set {
            
        }
    }
    
    /// The path to draw. The five lines of the staff plus as many ledger lines as will fit in the view (just don't stop drawing ledger lines until you run out of room).
    ///
    /// - Returns: A CGPath representing the potential lines on the staff
    func staffPath() -> CGPath {
        let staffLines = UIBezierPath()
        //self.lineWidth = spaceWidth / 10.0
        
        //draw ledger lines until there's no more room to do it anymore.
        //they'll get masked out later in the process
        var height = self.bounds.origin.y
        while height <= self.bounds.size.height {
            staffLines.move(to: CGPoint(x: self.bounds.origin.x, y: height))
            staffLines.addLine(to: CGPoint(x: self.bounds.origin.x + self.bounds.size.width, y: height))
            height += spaceWidth
        }
        
        return staffLines.cgPath
    }
    
    /// The CGRects that should not be masked. When the elements have been placed, their frames will be added to this array to describe where the excess ledger lines need to be uncovered
    var unmaskRects = [CGRect]()
    
    /// The layer that will uncover the staff and ledger lines necessary
    var staffLineMask: CALayer? {
        //Unmask the staff itself
        let staffRect = self.bounds.insetBy(dx: 0.0, dy: CGFloat(maxLedgerLines + 1) * spaceWidth - lineWidth * 3.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.fillColor = UIColor.white.cgColor
        
        //create a mutable path so that other frames can be added to it
        let path = CGMutablePath()
        path.addRect(staffRect)

        //add all the frames that need to be unmasked
        for rect in unmaskRects {
            path.addRect(rect)
        }
        
        maskLayer.path = path
        return maskLayer
    }
   
}
