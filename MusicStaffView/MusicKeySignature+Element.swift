//
//  MusicKeySignature+Element.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 8/14/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicKeySignature: MusicStaffViewElement {
    public func layer(in clef: MusicClef, withSpaceWidth spaceWidth: CGFloat, color: UIColor?) -> CALayer {
        print("calling key signature layer")
        
        let finalLayer = CALayer()
        var xPosition: CGFloat = 0.0
        for pitch in pitches {
            let pitchLayer = pitch.layer(in: clef, withSpaceWidth: spaceWidth, color: color)
            xPosition += pitchLayer.bounds.size.width * pitchLayer.anchorPoint.x
            pitchLayer.position.x = xPosition
            finalLayer.addSublayer(pitchLayer)
            xPosition += pitchLayer.bounds.size.width * (1 - pitchLayer.anchorPoint.x)
            finalLayer.bounds.size.width = xPosition
        }
        return finalLayer
    }
    
    public func path(in frame: CGRect) -> CGPath {
        fatalError("Key signatures are constructed from their various child elements in layer:")
    }
    
    public var aspectRatio: CGFloat {
        fatalError("Key signatures are constructed from their various child elements in layer:")
    }
    
    public var heightInStaffSpace: CGFloat {
        fatalError("Key signatures are constructed from their various child elements in layer:")
    }
}
