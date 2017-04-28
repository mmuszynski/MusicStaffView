//
//  MusicNote+Element.swift
//  Music
//
//  Created by Mike Muszynski on 4/17/17.
//  Copyright (c) 2017 Mike Muszynski. All rights reserved.
//

import UIKit
import Music

extension MusicNote: MusicStaffViewElement {
    
    public func direction(in clef: MusicClef) -> MusicStaffViewElementDirection {
        let offset = clef.offsetForPitch(named: self.pitch.name, octave: self.pitch.octave)
        return offset > 0 ? .up : .down
    }
    
    public func offset(in clef: MusicClef) -> Int {
        return clef.offsetForPitch(named: self.pitch.name, octave: self.pitch.octave)
    }
    
    public func requiresLedgerLines(in clef: MusicClef) -> Bool {
        return abs(offset(in: clef)) > 5
    }
    
    public func path(in frame: CGRect) -> CGPath {
        switch self.rhythm {
        case .quarter, .crotchet:
            return quarterNotePath(in: frame)
        default:
            return quarterNotePath(in: frame)
        }
    }
    
    public var aspectRatio: CGFloat {
        return 39.0 / 90.0
    }
    
    public var heightInStaffSpace: CGFloat {
        return 4.0
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint(x: 0.5, y: 0.865)
    }
    
    public var accessoryElements: [MusicStaffViewAccessory]? {
        if self.accidental != .none {
            return [self.accidental]
        }
        return nil
    }
    
    func quarterNotePath(in frame: CGRect) -> CGPath {        
        let quarterNotePath = UIBezierPath()
        quarterNotePath.move(to: CGPoint(x: frame.minX + 0.93974 * frame.width, y: frame.minY + 0.01905 * frame.height))
        quarterNotePath.addLine(to: CGPoint(x: frame.minX + 0.93974 * frame.width, y: frame.minY + 0.81048 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.88590 * frame.width, y: frame.minY + 0.87190 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.93974 * frame.width, y: frame.minY + 0.83143 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.92180 * frame.width, y: frame.minY + 0.85190 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.74615 * frame.width, y: frame.minY + 0.92524 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.85000 * frame.width, y: frame.minY + 0.89190 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.80342 * frame.width, y: frame.minY + 0.90968 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.55513 * frame.width, y: frame.minY + 0.96238 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.68889 * frame.width, y: frame.minY + 0.94079 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.62521 * frame.width, y: frame.minY + 0.95317 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.35000 * frame.width, y: frame.minY + 0.97619 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.48504 * frame.width, y: frame.minY + 0.97159 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.42360 * frame.width, y: frame.minY + 0.97784 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.14487 * frame.width, y: frame.minY + 0.95524 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.25941 * frame.width, y: frame.minY + 0.97416 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.19957 * frame.width, y: frame.minY + 0.96921 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.06282 * frame.width, y: frame.minY + 0.90381 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.09017 * frame.width, y: frame.minY + 0.94127 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.06282 * frame.width, y: frame.minY + 0.93048 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.11795 * frame.width, y: frame.minY + 0.85048 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.06282 * frame.width, y: frame.minY + 0.88222 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.08120 * frame.width, y: frame.minY + 0.87079 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.25897 * frame.width, y: frame.minY + 0.79714 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.15470 * frame.width, y: frame.minY + 0.83016 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.20171 * frame.width, y: frame.minY + 0.81238 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.44744 * frame.width, y: frame.minY + 0.76048 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.31624 * frame.width, y: frame.minY + 0.78190 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.37906 * frame.width, y: frame.minY + 0.76968 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.65520 * frame.width, y: frame.minY + 0.75095 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.51581 * frame.width, y: frame.minY + 0.75127 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.59024 * frame.width, y: frame.minY + 0.75095 * frame.height))
        quarterNotePath.addCurve(to: CGPoint(x: frame.minX + 0.88590 * frame.width, y: frame.minY + 0.77952 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.75776 * frame.width, y: frame.minY + 0.75095 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.83120 * frame.width, y: frame.minY + 0.75921 * frame.height))
        quarterNotePath.addLine(to: CGPoint(x: frame.minX + 0.88333 * frame.width, y: frame.minY + 0.01905 * frame.height))
        quarterNotePath.addLine(to: CGPoint(x: frame.minX + 0.93974 * frame.width, y: frame.minY + 0.01905 * frame.height))
        quarterNotePath.close()
        
        return quarterNotePath.cgPath
    }
    
}
