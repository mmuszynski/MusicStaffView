//
//  MusicStaffViewStaffLayer.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

class MusicStaffViewStaffLayer: CAShapeLayer {
    
    var maxLedgerLines : Int = 0
    var currentHorizontalPosition : CGFloat {
        get {
            guard let sublayers = self.sublayers, let lastElement = sublayers.last else {
                return 0
            }
            
            return lastElement.frame.origin.x + lastElement.frame.size.width
        }
    }
    
    var staffLinesLayer = CALayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        strokeColor = UIColor.black.cgColor
    }
    
    override init() {
        super.init()
        strokeColor = UIColor.black.cgColor
    }
    
    override var path : CGPath! {
        get {
            return staffPath()
        }
        set {
            
        }
    }
    
    var spaceWidth: CGFloat {
        return self.bounds.size.height / (6.0 + 2.0 * CGFloat(maxLedgerLines))
    }
    
    func staffPath() -> CGPath {
        let staffLines = UIBezierPath()
        self.lineWidth = spaceWidth / 10.0
        
        for i in -(2+maxLedgerLines)...(2 + maxLedgerLines) {
            let height = self.bounds.origin.y + spaceWidth * CGFloat(i+5)
            staffLines.move(to: CGPoint(x: self.bounds.origin.x, y: height))
            staffLines.addLine(to: CGPoint(x: self.bounds.origin.x + self.bounds.size.width, y: height))
        }
        
        return staffLines.cgPath
    }
    
    var unmaskRects = [CGRect]()
    
    //mask the ledger lines that were drawn
    var staffLineMask: CALayer? {
        let staffRect = self.bounds.insetBy(dx: 0.0, dy: CGFloat(maxLedgerLines + 1) * spaceWidth - lineWidth * 2.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.fillColor = UIColor.white.cgColor
        
        let path = CGMutablePath()
        path.addRect(staffRect)

        for rect in unmaskRects {
            path.addRect(rect)
        }
        
        maskLayer.path = path
        return maskLayer
    }
   
}
