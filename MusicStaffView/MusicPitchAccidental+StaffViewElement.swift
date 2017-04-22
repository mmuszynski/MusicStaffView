//
//  MusicPitchAccidental+StaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/19/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicPitchAccidental: MusicStaffViewElement {
    func requiresLedgerLines(in clef: MusicClef) -> Bool {
        return false
    }

    public func path(in frame: CGRect) -> CGPath {
        return naturalPath(in: frame)
    }

    public var aspectRatio: CGFloat {
        return 16.0 / 45.0
    }

    public var heightInStaffSpace: CGFloat {
        return 0.70 * 4.0
    }

    public var anchorPoint: CGPoint {
        return CGPoint(x: 0.5, y: 0.865)
    }

    func naturalPath(in frame: CGRect) -> CGPath {
        let naturalPath = UIBezierPath()
        
        naturalPath.move(to: CGPoint(x: frame.minX + 0.84750 * frame.width, y: frame.minY + 0.94356 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.84750 * frame.width, y: frame.minY + 0.22756 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.27375 * frame.width, y: frame.minY + 0.29956 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.27375 * frame.width, y: frame.minY + 0.03156 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.18000 * frame.width, y: frame.minY + 0.03156 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.18000 * frame.width, y: frame.minY + 0.74756 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.75375 * frame.width, y: frame.minY + 0.67689 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.75375 * frame.width, y: frame.minY + 0.94356 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.84750 * frame.width, y: frame.minY + 0.94356 * frame.height))
        naturalPath.close()
        naturalPath.move(to: CGPoint(x: frame.minX + 0.27375 * frame.width, y: frame.minY + 0.40756 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.75375 * frame.width, y: frame.minY + 0.34489 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.75375 * frame.width, y: frame.minY + 0.56889 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.27375 * frame.width, y: frame.minY + 0.63022 * frame.height))
        naturalPath.addLine(to: CGPoint(x: frame.minX + 0.27375 * frame.width, y: frame.minY + 0.40756 * frame.height))
        naturalPath.close()
        
        return naturalPath.cgPath
    }

}

