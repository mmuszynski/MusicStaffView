//
//  MusicPitchAccidental+StaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/19/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicPitchAccidental: MusicStaffViewAccessory {    
    public var placement: MusicStaffViewAccessoryPlacement {
        return .leading
    }
    
    public func requiresLedgerLines(in clef: MusicClef) -> Bool {
        return false
    }

    public func path(in frame: CGRect) -> CGPath {
        switch self {
        case .flat:
            return flatPath(in: frame)
        case .natural:
            return naturalPath(in: frame)
        case .sharp:
            return sharpPath(in: frame)
        default:
            fatalError("not yet implemented")
        }
    }

    public var aspectRatio: CGFloat {
        switch self {
        case .natural:
            return 16.0 / 45.0
        case .flat:
            return 16.0 / 45.0
        case .sharp:
            return 16.0 / 45.0
        default:
            fatalError("not yet implemented")
        }
    }

    public var heightInStaffSpace: CGFloat {
        return 0.70 * 4.0
    }

    public var anchorPoint: CGPoint {
        switch self {
        case .flat:
            return CGPoint(x: 0.5, y: 0.73)
        case .natural:
            return CGPoint(x: 0.5, y: 0.475)
        case .sharp:
            return CGPoint(x: 0.5, y: 0.475)
        default:
            fatalError()
        }
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
    
    func sharpPath(in frame: CGRect) -> CGPath {
        let sharpPath = UIBezierPath()
        sharpPath.move(to: CGPoint(x: frame.minX + 0.34256 * frame.width, y: frame.minY + 0.63675 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.34256 * frame.width, y: frame.minY + 0.39325 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.66914 * frame.width, y: frame.minY + 0.36468 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.66914 * frame.width, y: frame.minY + 0.60693 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.34256 * frame.width, y: frame.minY + 0.63675 * frame.height))
        sharpPath.close()
        sharpPath.move(to: CGPoint(x: frame.minX + 0.98559 * frame.width, y: frame.minY + 0.57784 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.76107 * frame.width, y: frame.minY + 0.59824 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.76107 * frame.width, y: frame.minY + 0.35598 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.98559 * frame.width, y: frame.minY + 0.33610 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.98559 * frame.width, y: frame.minY + 0.23547 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.76107 * frame.width, y: frame.minY + 0.25535 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.76107 * frame.width, y: frame.minY + 0.00782 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.66914 * frame.width, y: frame.minY + 0.00782 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.66914 * frame.width, y: frame.minY + 0.26285 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.34256 * frame.width, y: frame.minY + 0.29262 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.34256 * frame.width, y: frame.minY + 0.05192 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.25585 * frame.width, y: frame.minY + 0.05192 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.25585 * frame.width, y: frame.minY + 0.30178 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.03133 * frame.width, y: frame.minY + 0.32171 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.03133 * frame.width, y: frame.minY + 0.42255 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.25585 * frame.width, y: frame.minY + 0.40267 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.25585 * frame.width, y: frame.minY + 0.64446 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.03133 * frame.width, y: frame.minY + 0.66429 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.03133 * frame.width, y: frame.minY + 0.76471 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.25585 * frame.width, y: frame.minY + 0.74484 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.25585 * frame.width, y: frame.minY + 0.99097 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.34256 * frame.width, y: frame.minY + 0.99097 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.34256 * frame.width, y: frame.minY + 0.73604 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.66914 * frame.width, y: frame.minY + 0.70757 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.66914 * frame.width, y: frame.minY + 0.94702 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.76107 * frame.width, y: frame.minY + 0.94702 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.76107 * frame.width, y: frame.minY + 0.69856 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.98559 * frame.width, y: frame.minY + 0.67863 * frame.height))
        sharpPath.addLine(to: CGPoint(x: frame.minX + 0.98559 * frame.width, y: frame.minY + 0.57784 * frame.height))
        sharpPath.close()

        return sharpPath.cgPath
    }
    
    func flatPath(in frame: CGRect) -> CGPath {
        let flatPath = UIBezierPath()
        flatPath.move(to: CGPoint(x: frame.minX + 0.57727 * frame.width, y: frame.minY + 0.77042 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.14863 * frame.width, y: frame.minY + 0.91469 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.43202 * frame.width, y: frame.minY + 0.83467 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.30975 * frame.width, y: frame.minY + 0.87145 * frame.height))
        flatPath.addLine( to: CGPoint(x: frame.minX + 0.14863 * frame.width, y: frame.minY + 0.70180 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.31091 * frame.width, y: frame.minY + 0.62221 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.18526 * frame.width, y: frame.minY + 0.66906 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.23928 * frame.width, y: frame.minY + 0.64256 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.52790 * frame.width, y: frame.minY + 0.59176 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.38231 * frame.width, y: frame.minY + 0.60194 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.45464 * frame.width, y: frame.minY + 0.59176 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.57727 * frame.width, y: frame.minY + 0.77042 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.87003 * frame.width, y: frame.minY + 0.60934 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.75021 * frame.width, y: frame.minY + 0.71227 * frame.height))
        flatPath.close()
        flatPath.move( to: CGPoint(x: frame.minX + 0.14863 * frame.width, y: frame.minY + 0.59685 * frame.height))
        flatPath.addLine( to: CGPoint(x: frame.minX + 0.14863 * frame.width, y: frame.minY + 0.00018 * frame.height))
        flatPath.addLine( to: CGPoint(x: frame.minX + 0.01812 * frame.width, y: frame.minY + 0.00018 * frame.height))
        flatPath.addLine( to: CGPoint(x: frame.minX + 0.01812 * frame.width, y: frame.minY + 0.95342 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.08488 * frame.width, y: frame.minY + 0.99674 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.01812 * frame.width, y: frame.minY + 0.98230 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.04037 * frame.width, y: frame.minY + 0.99674 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.19036 * frame.width, y: frame.minY + 0.97902 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.11062 * frame.width, y: frame.minY + 0.99674 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.14259 * frame.width, y: frame.minY + 0.98911 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.93262 * frame.width, y: frame.minY + 0.74963 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.51536 * frame.width, y: frame.minY + 0.90818 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.72413 * frame.width, y: frame.minY + 0.85083 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.94934 * frame.width, y: frame.minY + 0.59786 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.99707 * frame.width, y: frame.minY + 0.71835 * frame.height), controlPoint2: CGPoint(x: frame.minX + 1.04265 * frame.width, y: frame.minY + 0.64741 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.63816 * frame.width, y: frame.minY + 0.52491 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.89116 * frame.width, y: frame.minY + 0.56696 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.78027 * frame.width, y: frame.minY + 0.53451 * frame.height))
        flatPath.addCurve( to: CGPoint(x: frame.minX + 0.14863 * frame.width, y: frame.minY + 0.59685 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.45420 * frame.width, y: frame.minY + 0.51250 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.29555 * frame.width, y: frame.minY + 0.54492 * frame.height))
        flatPath.close()
        
        return flatPath.cgPath
    }

}

