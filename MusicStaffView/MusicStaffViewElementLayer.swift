//
//  MusicStaffViewElementLayer.swift
//  Music
//
//  Created by Mike Muszynski on 1/5/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

class MusicStaffViewElementLayer: CAShapeLayer {
    
    let type : MusicStaffViewElementType
    var preferredElementSpacing : CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        type = MusicStaffViewElementType.none
        super.init(coder: aDecoder)
    }
    
    init(type: MusicStaffViewElementType) {
        self.type = type
        super.init()
        self.strokeColor = nil

        switch type {
        case .clef(.gClef):
            self.anchorPoint = CGPoint(x: -0.1, y: 0.61);
        case .note:
            self.anchorPoint = CGPoint(x: 0.5, y: 0.865);
        case .accidental(.sharp):
            fallthrough
        case .accidental(.natural):
            self.anchorPoint = CGPoint(x: 0, y: 0.475);
        case .accidental(.flat):
            self.anchorPoint = CGPoint(x: 0.1, y: 0.7);
        default:
            break
        }

    }
    
    var height : CGFloat {
        set(newHeight) {
            var aspectRatio : CGFloat
            
            switch type {
            case .note(_, _, let length):
                if (length == .quarter) {
                    aspectRatio = 39.0 / 90.0
                } else {
                    aspectRatio = 103.0 / 291.0
                }
            case .accidental(.natural):
                aspectRatio = 16.0 / 45.0
            default:
                aspectRatio = 103.0 / 291.0
            }
            
            self.bounds = CGRect(x: 0, y: 0, width: newHeight * aspectRatio, height: newHeight)
        }
        get {
            return self.bounds.size.height
        }
    }
    
    override var path : CGPath! {
        get {
            
            switch type {
            case .clef(let clef):
                switch clef {
                case .gClef:
                    return trebleClefPath()
                default:
                    return trebleClefPath()
                }
                
            case .note(_, _, let length):
                switch length {
                case .quarter:
                    return quarterNotePath()
                default:
                    return quarterNotePath()
                }
            
            case .accidental(let type):
                switch type {
                case .sharp:
                    return sharpPath()
                case .natural:
                    return naturalPath()
                case .flat:
                    return flatPath()
                default:
                    return nil
                }
                
            default:
                return UIBezierPath(ovalIn: self.frame).cgPath
            }
            

        }
        set {
            
        }
    }
    
    func staffPath() -> CGPath {

        switch type {
        case .clef(.gClef):
            return trebleClefPath()
        default:
            break
        }
        
        return trebleClefPath()
        
    }
    
    func trebleClefPath() -> CGPath {
        let layer1 = self.bounds
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: layer1.minX + 0.17216 * layer1.width, y: layer1.minY + 0.92151 * layer1.height))
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.34186 * layer1.width, y: layer1.minY + 0.99545 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.17216 * layer1.width, y: layer1.minY + 0.95346 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.26774 * layer1.width, y: layer1.minY + 0.99012 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.48633 * layer1.width, y: layer1.minY + 0.99696 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.34186 * layer1.width, y: layer1.minY + 0.99545 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.42111 * layer1.width, y: layer1.minY + 1.00298 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.69978 * layer1.width, y: layer1.minY + 0.88324 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.49811 * layer1.width, y: layer1.minY + 0.99797 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.69583 * layer1.width, y: layer1.minY + 0.98416 * layer1.height));
        bezierPath.addLine(to: CGPoint(x: layer1.minX + 0.65808 * layer1.width, y: layer1.minY + 0.76043 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.80453 * layer1.width, y: layer1.minY + 0.73564 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.68587 * layer1.width, y: layer1.minY + 0.75862 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.77654 * layer1.width, y: layer1.minY + 0.74197 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.94485 * layer1.width, y: layer1.minY + 0.67464 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.88133 * layer1.width, y: layer1.minY + 0.71827 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.91494 * layer1.width, y: layer1.minY + 0.69320 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.99822 * layer1.width, y: layer1.minY + 0.59742 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.97845 * layer1.width, y: layer1.minY + 0.64678 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.99822 * layer1.width, y: layer1.minY + 0.62775 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.63376 * layer1.width, y: layer1.minY + 0.45851 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.99822 * layer1.width, y: layer1.minY + 0.52070 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.83505 * layer1.width, y: layer1.minY + 0.45851 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.54949 * layer1.width, y: layer1.minY + 0.46226 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.60475 * layer1.width, y: layer1.minY + 0.45851 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.57657 * layer1.width, y: layer1.minY + 0.45982 * layer1.height));
        bezierPath.addLine(to: CGPoint(x: layer1.minX + 0.51352 * layer1.width, y: layer1.minY + 0.36369 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.83417 * layer1.width, y: layer1.minY + 0.17008 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.64973 * layer1.width, y: layer1.minY + 0.30599 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.78780 * layer1.width, y: layer1.minY + 0.23507 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.73733 * layer1.width, y: layer1.minY + 0.00139 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.87963 * layer1.width, y: layer1.minY + 0.08423 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.85789 * layer1.width, y: layer1.minY + 0.02624 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.41320 * layer1.width, y: layer1.minY + 0.13242 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.62665 * layer1.width, y: layer1.minY + -0.00840 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.49229 * layer1.width, y: layer1.minY + 0.04921 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.45668 * layer1.width, y: layer1.minY + 0.29659 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.36181 * layer1.width, y: layer1.minY + 0.17685 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.42727 * layer1.width, y: layer1.minY + 0.26174 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.00212 * layer1.width, y: layer1.minY + 0.56963 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.24003 * layer1.width, y: layer1.minY + 0.37573 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.02449 * layer1.width, y: layer1.minY + 0.43248 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.51230 * layer1.width, y: layer1.minY + 0.76409 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.00212 * layer1.width, y: layer1.minY + 0.67704 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.23055 * layer1.width, y: layer1.minY + 0.76409 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.63429 * layer1.width, y: layer1.minY + 0.76183 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.53922 * layer1.width, y: layer1.minY + 0.76409 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.58369 * layer1.width, y: layer1.minY + 0.76433 * layer1.height));
        bezierPath.addLine(to: CGPoint(x: layer1.minX + 0.65808 * layer1.width, y: layer1.minY + 0.88448 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.48804 * layer1.width, y: layer1.minY + 0.98634 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.65808 * layer1.width, y: layer1.minY + 0.88448 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.66721 * layer1.width, y: layer1.minY + 0.97418 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.36807 * layer1.width, y: layer1.minY + 0.97881 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.41692 * layer1.width, y: layer1.minY + 0.99116 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.34834 * layer1.width, y: layer1.minY + 0.99675 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.48804 * layer1.width, y: layer1.minY + 0.92151 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.42349 * layer1.width, y: layer1.minY + 0.96781 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.48804 * layer1.width, y: layer1.minY + 0.95028 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.33012 * layer1.width, y: layer1.minY + 0.85669 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.48804 * layer1.width, y: layer1.minY + 0.88571 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.41731 * layer1.width, y: layer1.minY + 0.85669 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.17216 * layer1.width, y: layer1.minY + 0.92151 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.24288 * layer1.width, y: layer1.minY + 0.85669 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.17216 * layer1.width, y: layer1.minY + 0.88571 * layer1.height));
        bezierPath.close();
        bezierPath.move(to: CGPoint(x: layer1.minX + 0.49250 * layer1.width, y: layer1.minY + 0.37258 * layer1.height));
        bezierPath.addLine(to: CGPoint(x: layer1.minX + 0.52606 * layer1.width, y: layer1.minY + 0.46467 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.26936 * layer1.width, y: layer1.minY + 0.59742 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.37739 * layer1.width, y: layer1.minY + 0.48218 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.26936 * layer1.width, y: layer1.minY + 0.53501 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.48499 * layer1.width, y: layer1.minY + 0.68423 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.26936 * layer1.width, y: layer1.minY + 0.66806 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.49100 * layer1.width, y: layer1.minY + 0.70100 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.36656 * layer1.width, y: layer1.minY + 0.61593 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.39858 * layer1.width, y: layer1.minY + 0.67003 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.36656 * layer1.width, y: layer1.minY + 0.65407 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.54851 * layer1.width, y: layer1.minY + 0.52630 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.36656 * layer1.width, y: layer1.minY + 0.57282 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.44388 * layer1.width, y: layer1.minY + 0.53661 * layer1.height));
        bezierPath.addLine(to: CGPoint(x: layer1.minX + 0.62832 * layer1.width, y: layer1.minY + 0.74553 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.57002 * layer1.width, y: layer1.minY + 0.75020 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.61037 * layer1.width, y: layer1.minY + 0.74739 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.59100 * layer1.width, y: layer1.minY + 0.74895 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.12358 * layer1.width, y: layer1.minY + 0.57889 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.26632 * layer1.width, y: layer1.minY + 0.74788 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.12358 * layer1.width, y: layer1.minY + 0.68630 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.49250 * layer1.width, y: layer1.minY + 0.37258 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.12359 * layer1.width, y: layer1.minY + 0.51872 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.30953 * layer1.width, y: layer1.minY + 0.44932 * layer1.height));
        bezierPath.close();
        bezierPath.move(to: CGPoint(x: layer1.minX + 0.65164 * layer1.width, y: layer1.minY + 0.74284 * layer1.height));
        bezierPath.addLine(to: CGPoint(x: layer1.minX + 0.57207 * layer1.width, y: layer1.minY + 0.52445 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.60951 * layer1.width, y: layer1.minY + 0.52333 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.58424 * layer1.width, y: layer1.minY + 0.52372 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.59678 * layer1.width, y: layer1.minY + 0.52333 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.85244 * layer1.width, y: layer1.minY + 0.61593 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.74366 * layer1.width, y: layer1.minY + 0.52333 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.85244 * layer1.width, y: layer1.minY + 0.56480 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.65164 * layer1.width, y: layer1.minY + 0.74284 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.84976 * layer1.width, y: layer1.minY + 0.65708 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.84461 * layer1.width, y: layer1.minY + 0.71835 * layer1.height));
        bezierPath.close();
        bezierPath.move(to: CGPoint(x: layer1.minX + 0.48239 * layer1.width, y: layer1.minY + 0.28304 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.50926 * layer1.width, y: layer1.minY + 0.15062 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.42764 * layer1.width, y: layer1.minY + 0.21266 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.47713 * layer1.width, y: layer1.minY + 0.17758 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.72002 * layer1.width, y: layer1.minY + 0.04314 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.58519 * layer1.width, y: layer1.minY + 0.08695 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.65200 * layer1.width, y: layer1.minY + 0.06380 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.75528 * layer1.width, y: layer1.minY + 0.15062 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.80849 * layer1.width, y: layer1.minY + 0.05636 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.76856 * layer1.width, y: layer1.minY + 0.15062 * layer1.height));
        bezierPath.addCurve(to: CGPoint(x: layer1.minX + 0.48239 * layer1.width, y: layer1.minY + 0.28304 * layer1.height), controlPoint1:CGPoint(x: layer1.minX + 0.71362 * layer1.width, y: layer1.minY + 0.20623 * layer1.height), controlPoint2:CGPoint(x: layer1.minX + 0.56417 * layer1.width, y: layer1.minY + 0.25043 * layer1.height));
        bezierPath.close();
        
        
        return bezierPath.cgPath;

    }
    
    func quarterNotePath() -> CGPath {
        let frame = self.bounds
        
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
    
    func flatPath() -> CGPath {
        let frame = self.bounds
        
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
    
    func sharpPath() -> CGPath {
        let frame = self.bounds
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
    
    func naturalPath() -> CGPath {
        let frame = self.bounds
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
