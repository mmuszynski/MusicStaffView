//
//  MusicStaffViewAccessory.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/24/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

public enum MusicStaffViewAccessoryPlacement {
    case above, below, leading, trailing, standalone
}

//This seems like it is either overkill or will be incredibly useful.
public enum MusicStaffViewAccessorySpacing {
    case flexible
    case zero
    case minimal
    case preferred
    case specific(_: CGFloat)
    case proportional(_: CGFloat)
}

public protocol MusicStaffViewAccessory: MusicStaffViewElement {
    var placement: MusicStaffViewAccessoryPlacement { get }
    var spacing: MusicStaffViewAccessorySpacing { get }
    var avoidsCollisionsWithStaffLines: Bool { get }
    func collisionAvoidanceAmountInStaffSpace(for clef: MusicClef) -> CGFloat
}

extension MusicStaffViewAccessory {
    public var avoidsCollisionsWithStaffLines: Bool { return false }
    public func collisionAvoidanceAmountInStaffSpace(for clef: MusicClef) -> CGFloat { return 0.0 }
}
