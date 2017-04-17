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
    
    func staffPath() -> CGPath {
        let staffLines = UIBezierPath()
        let spaceWidth : CGFloat = self.bounds.size.height / (6.0 + 2.0 * CGFloat(maxLedgerLines))
        self.lineWidth = spaceWidth / 10.0
        
        for i in 1...(5 + maxLedgerLines) {
            if (i <= maxLedgerLines || i > 5 + maxLedgerLines) {
                continue
            }
            
            let height = self.bounds.origin.y + spaceWidth * CGFloat(i)
            staffLines.move(to: CGPoint(x: self.bounds.origin.x, y: height))
            staffLines.addLine(to: CGPoint(x: self.bounds.origin.x + self.bounds.size.width, y: height))
        }
        
        return staffLines.cgPath
    }
   
}
