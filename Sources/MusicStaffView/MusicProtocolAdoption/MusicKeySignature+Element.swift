//
//  MusicKeySignature+Element.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 8/14/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

import Foundation
import Music

extension MusicKeySignature: MusicStaffViewAccessory {
    public var placement: MusicStaffViewAccessoryPlacement {
        return .standalone
    }
    
    public var spacing: MusicStaffViewAccessorySpacing {
        return .proportional(0.5)
    }
    
    public func layer(in clef: MusicClef, withSpaceWidth spaceWidth: CGFloat, color: ColorType?) throws -> CALayer {
        let finalLayer = CALayer()
        var xPosition: CGFloat = 0.0
        for pitch in pitches {
            let pitchLayer = try pitch.layer(in: clef, withSpaceWidth: spaceWidth, color: color)
            xPosition += pitchLayer.bounds.size.width * pitchLayer.anchorPoint.x
            pitchLayer.position.x = xPosition
            finalLayer.addSublayer(pitchLayer)
            xPosition += pitchLayer.bounds.size.width * (1 - pitchLayer.anchorPoint.x)
            finalLayer.bounds.size.width = xPosition
        }
        return finalLayer
    }
    
    public func path(in frame: CGRect, for direction: MusicStaffViewElementDirection) -> CGPath {
        fatalError("Key signatures are constructed from their various child elements in layer:")
    }
    
    public var aspectRatio: CGFloat {
        fatalError("Key signatures are constructed from their various child elements in layer:")
    }
    
    public var heightInStaffSpace: CGFloat {
        fatalError("Key signatures are constructed from their various child elements in layer:")
    }
}
