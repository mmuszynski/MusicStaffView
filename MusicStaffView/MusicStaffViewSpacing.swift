//
//  MusicStaffViewSpacing.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/27/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

public struct MusicStaffViewShim: MusicStaffViewElement {
    public var width: CGFloat
    
    public init(width: CGFloat) {
        self.width = width
    }
    
    public func path(in frame: CGRect) -> CGPath {
        let path = CGPath(rect: frame, transform: nil)
        return path
    }
    
    public var aspectRatio: CGFloat {
        return width / heightInStaffSpace
    }
    
    public var heightInStaffSpace: CGFloat {
        return 4.0
    }
    
    public var fillColor: UIColor {
        return UIColor.clear
    }
    
}
