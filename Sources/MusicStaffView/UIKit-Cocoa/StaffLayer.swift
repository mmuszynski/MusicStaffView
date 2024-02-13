//
//  MusicStaffViewStaffLayer.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif

class MusicStaffViewStaffLayer: CAShapeLayer {
    
    /// The maximum number of ledger lines to be drawn. This is controlled by the `MusicStaffView` instance and is not called directly.
    var maxLedgerLines : Int = 0
    var ledgerLines: (above: Int, below: Int)?
    var totalLedgerLines: Int {
        if let ledger = ledgerLines {
            return ledger.above + ledger.below
        } else {
            return 2 * maxLedgerLines
        }
    }
    
    var spaceWidth: CGFloat {
        UIMusicStaffView.spaceWidth(in: self.bounds, ledgerLines: self.totalLedgerLines)
    }
    
    /// The path described by the staff lines.
    override var path : CGPath! {
        get {
            return UIMusicStaffView.staffPath(in: self.bounds, spaceWidth: self.spaceWidth)
        }
        set {
            
        }
    }
    
    override var lineWidth: CGFloat {
        get {
            return spaceWidth / 10.0
        }
        set {
            
        }
    }
    
    /// The CGRects that should not be masked. When the elements have been placed, their frames will be added to this array to describe where the excess ledger lines need to be uncovered
    var unmaskRects = [CGRect]()
    
    ///The height for the center line, which is the anchor point of all the offset values.
    private var centerlineHeight: CGFloat {
        if let ledgerLines = ledgerLines {
            let ledgerOffset = CGFloat(ledgerLines.above - ledgerLines.below) * self.spaceWidth / 2.0
            return self.bounds.size.height / 2.0 + ledgerOffset
        }
        
        return self.bounds.size.height / 2.0
    }
    
    /// The layer that will uncover the staff and ledger lines necessary
    var staffLineMask: CALayer? {
        //Unmask the staff itself
        let staffRect = CGRect(x: 0,
                               y: centerlineHeight - 2.0 * (self.spaceWidth + self.lineWidth),
                               width: self.bounds.size.width,
                               height: self.spaceWidth * 4.0 + self.lineWidth * 5.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.fillColor = ColorType.white.cgColor
        
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
