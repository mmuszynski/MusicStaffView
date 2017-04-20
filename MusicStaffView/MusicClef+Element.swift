//
//  MusicClef+Element.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/20/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicClef: MusicStaffViewElement {
    public func path(in frame: CGRect) -> CGPath {
        switch self {
        case .cClef(_):
            fatalError()
        case .fClef(_):
            fatalError()
        case .gClef(_):
            return trebleClefPath(in: frame)
        }
    }
    
    public var aspectRatio: CGFloat {
        switch self {
        case .gClef(_):
            return 103.0 / 291.0
        default:
            fatalError()
        }
    }
    
    public var heightInStaffSpace: CGFloat {
        switch self {
        case .gClef(_):
            return 6.5
        default:
            fatalError()
        }
    }
    
    public var anchorPoint: CGPoint {
        switch self {
        case .gClef(_):
            return CGPoint(x: 0.5, y: 0.61);
        default:
            fatalError()
        }
    }
    
    public func offset(in clef: MusicClef) -> Int {
        return self.offsetForPitch(named: referencePitch.name, octave: referencePitch.octave)
    }
    
    func trebleClefPath(in frame: CGRect) -> CGPath {
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: frame.minX + 0.17216 * frame.width, y: frame.minY + 0.92151 * frame.height))
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.34186 * frame.width, y: frame.minY + 0.99545 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.17216 * frame.width, y: frame.minY + 0.95346 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.26774 * frame.width, y: frame.minY + 0.99012 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48633 * frame.width, y: frame.minY + 0.99696 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.34186 * frame.width, y: frame.minY + 0.99545 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.42111 * frame.width, y: frame.minY + 1.00298 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.69978 * frame.width, y: frame.minY + 0.88324 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.49811 * frame.width, y: frame.minY + 0.99797 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.69583 * frame.width, y: frame.minY + 0.98416 * frame.height));
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.65808 * frame.width, y: frame.minY + 0.76043 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.80453 * frame.width, y: frame.minY + 0.73564 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.68587 * frame.width, y: frame.minY + 0.75862 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.77654 * frame.width, y: frame.minY + 0.74197 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.94485 * frame.width, y: frame.minY + 0.67464 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.88133 * frame.width, y: frame.minY + 0.71827 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.91494 * frame.width, y: frame.minY + 0.69320 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.99822 * frame.width, y: frame.minY + 0.59742 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.97845 * frame.width, y: frame.minY + 0.64678 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.99822 * frame.width, y: frame.minY + 0.62775 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.63376 * frame.width, y: frame.minY + 0.45851 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.99822 * frame.width, y: frame.minY + 0.52070 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.83505 * frame.width, y: frame.minY + 0.45851 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.54949 * frame.width, y: frame.minY + 0.46226 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.60475 * frame.width, y: frame.minY + 0.45851 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.57657 * frame.width, y: frame.minY + 0.45982 * frame.height));
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.51352 * frame.width, y: frame.minY + 0.36369 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.83417 * frame.width, y: frame.minY + 0.17008 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.64973 * frame.width, y: frame.minY + 0.30599 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.78780 * frame.width, y: frame.minY + 0.23507 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.73733 * frame.width, y: frame.minY + 0.00139 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.87963 * frame.width, y: frame.minY + 0.08423 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.85789 * frame.width, y: frame.minY + 0.02624 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.41320 * frame.width, y: frame.minY + 0.13242 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.62665 * frame.width, y: frame.minY + -0.00840 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.49229 * frame.width, y: frame.minY + 0.04921 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.45668 * frame.width, y: frame.minY + 0.29659 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.36181 * frame.width, y: frame.minY + 0.17685 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.42727 * frame.width, y: frame.minY + 0.26174 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.00212 * frame.width, y: frame.minY + 0.56963 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.24003 * frame.width, y: frame.minY + 0.37573 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.02449 * frame.width, y: frame.minY + 0.43248 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.51230 * frame.width, y: frame.minY + 0.76409 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.00212 * frame.width, y: frame.minY + 0.67704 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.23055 * frame.width, y: frame.minY + 0.76409 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.63429 * frame.width, y: frame.minY + 0.76183 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.53922 * frame.width, y: frame.minY + 0.76409 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.58369 * frame.width, y: frame.minY + 0.76433 * frame.height));
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.65808 * frame.width, y: frame.minY + 0.88448 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48804 * frame.width, y: frame.minY + 0.98634 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.65808 * frame.width, y: frame.minY + 0.88448 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.66721 * frame.width, y: frame.minY + 0.97418 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.36807 * frame.width, y: frame.minY + 0.97881 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.41692 * frame.width, y: frame.minY + 0.99116 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.34834 * frame.width, y: frame.minY + 0.99675 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48804 * frame.width, y: frame.minY + 0.92151 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.42349 * frame.width, y: frame.minY + 0.96781 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.48804 * frame.width, y: frame.minY + 0.95028 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.33012 * frame.width, y: frame.minY + 0.85669 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.48804 * frame.width, y: frame.minY + 0.88571 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.41731 * frame.width, y: frame.minY + 0.85669 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.17216 * frame.width, y: frame.minY + 0.92151 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.24288 * frame.width, y: frame.minY + 0.85669 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.17216 * frame.width, y: frame.minY + 0.88571 * frame.height));
        bezierPath.close();
        bezierPath.move(to: CGPoint(x: frame.minX + 0.49250 * frame.width, y: frame.minY + 0.37258 * frame.height));
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.52606 * frame.width, y: frame.minY + 0.46467 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.26936 * frame.width, y: frame.minY + 0.59742 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.37739 * frame.width, y: frame.minY + 0.48218 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.26936 * frame.width, y: frame.minY + 0.53501 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48499 * frame.width, y: frame.minY + 0.68423 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.26936 * frame.width, y: frame.minY + 0.66806 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.49100 * frame.width, y: frame.minY + 0.70100 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.36656 * frame.width, y: frame.minY + 0.61593 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.39858 * frame.width, y: frame.minY + 0.67003 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.36656 * frame.width, y: frame.minY + 0.65407 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.54851 * frame.width, y: frame.minY + 0.52630 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.36656 * frame.width, y: frame.minY + 0.57282 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.44388 * frame.width, y: frame.minY + 0.53661 * frame.height));
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.62832 * frame.width, y: frame.minY + 0.74553 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.57002 * frame.width, y: frame.minY + 0.75020 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.61037 * frame.width, y: frame.minY + 0.74739 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.59100 * frame.width, y: frame.minY + 0.74895 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.12358 * frame.width, y: frame.minY + 0.57889 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.26632 * frame.width, y: frame.minY + 0.74788 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.12358 * frame.width, y: frame.minY + 0.68630 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.49250 * frame.width, y: frame.minY + 0.37258 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.12359 * frame.width, y: frame.minY + 0.51872 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.30953 * frame.width, y: frame.minY + 0.44932 * frame.height));
        bezierPath.close();
        bezierPath.move(to: CGPoint(x: frame.minX + 0.65164 * frame.width, y: frame.minY + 0.74284 * frame.height));
        bezierPath.addLine(to: CGPoint(x: frame.minX + 0.57207 * frame.width, y: frame.minY + 0.52445 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.60951 * frame.width, y: frame.minY + 0.52333 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.58424 * frame.width, y: frame.minY + 0.52372 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.59678 * frame.width, y: frame.minY + 0.52333 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.85244 * frame.width, y: frame.minY + 0.61593 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.74366 * frame.width, y: frame.minY + 0.52333 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.85244 * frame.width, y: frame.minY + 0.56480 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.65164 * frame.width, y: frame.minY + 0.74284 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.84976 * frame.width, y: frame.minY + 0.65708 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.84461 * frame.width, y: frame.minY + 0.71835 * frame.height));
        bezierPath.close();
        bezierPath.move(to: CGPoint(x: frame.minX + 0.48239 * frame.width, y: frame.minY + 0.28304 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.50926 * frame.width, y: frame.minY + 0.15062 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.42764 * frame.width, y: frame.minY + 0.21266 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.47713 * frame.width, y: frame.minY + 0.17758 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.72002 * frame.width, y: frame.minY + 0.04314 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.58519 * frame.width, y: frame.minY + 0.08695 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.65200 * frame.width, y: frame.minY + 0.06380 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.75528 * frame.width, y: frame.minY + 0.15062 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.80849 * frame.width, y: frame.minY + 0.05636 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.76856 * frame.width, y: frame.minY + 0.15062 * frame.height));
        bezierPath.addCurve(to: CGPoint(x: frame.minX + 0.48239 * frame.width, y: frame.minY + 0.28304 * frame.height), controlPoint1:CGPoint(x: frame.minX + 0.71362 * frame.width, y: frame.minY + 0.20623 * frame.height), controlPoint2:CGPoint(x: frame.minX + 0.56417 * frame.width, y: frame.minY + 0.25043 * frame.height));
        bezierPath.close();
        
        
        return bezierPath.cgPath
    }
}
