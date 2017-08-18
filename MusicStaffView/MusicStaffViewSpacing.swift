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
    public var spaceWidth: CGFloat
    public var isFlexible: Bool = false
    
    public init(width: CGFloat, spaceWidth: CGFloat = 1.0) {
        self.width = width
        self.spaceWidth = spaceWidth
    }
    
    public func path(in frame: CGRect) -> CGPath {
        let path = CGPath(rect: frame, transform: nil)
        return path
    }
    
    public var aspectRatio: CGFloat {
        return width
    }
    
    public var heightInStaffSpace: CGFloat {
        return 1.0 / spaceWidth
    }
    
    public var fillColor: UIColor {
        return UIColor.clear
    }
}
