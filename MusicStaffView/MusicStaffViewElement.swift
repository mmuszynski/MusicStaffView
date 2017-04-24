//
//  MusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit
import Music

public enum MusicStaffViewElementDirection {
    case up
    case down
}

protocol MusicStaffViewElement {
    /// The path that describes the shape of the element
    func path(in frame: CGRect) -> CGPath
    //func layer(in frame: CGRect) -> CALayer
    func layer(withSpaceWidth spaceWidth: CGFloat) -> CALayer
    
    /// The ratio of width to height that describes the general shape of the element's bounding box
    ///
    /// In order to remain resolution-independent, the `MusicStaffView` draws elements in terms of the size they appear relative to the height of spaces in the staff. For example, a quarter note is currently drawn at a height of 4.0 * spaceWidth. This value is used in conjunction with `heightInStaffSpaces` to compute the bounding box for the element.
    var aspectRatio: CGFloat { get }
    
    /// The height, represented as a fraction of one (or more) space widths
    ///
    /// In order to remain resolution-independent, the `MusicStaffView` draws elements in terms of the size they appear relative to the height of spaces in the staff. For example, a quarter note is currently drawn at a height of 4.0 * spaceWidth. This value is used in conjunction with `aspectRatio` to compute the bounding box for the element.
    var heightInStaffSpace: CGFloat { get }
    
    /// The anchor point that will eventually be used to center the image in the range of [0.0-1.0]
    var anchorPoint: CGPoint { get }
    
    func offset(in clef: MusicClef) -> Int
    func direction(in clef: MusicClef) -> MusicStaffViewElementDirection
    func requiresLedgerLines(in clef: MusicClef) -> Bool
    
    var accessoryElements: [MusicStaffViewAccessory]? { get }
    
}

extension MusicStaffViewElement {
    func layer(withSpaceWidth spaceWidth: CGFloat) -> CALayer {
        let frame = self.bounds(withSpaceWidth: spaceWidth)
        let layer = CAShapeLayer()
        layer.frame = frame
        layer.path = self.path(in: frame)
        layer.anchorPoint = self.anchorPoint
        return layer
    }
    
    func size(withSpaceWidth spaceWidth: CGFloat) -> CGSize {
        let height = self.heightInStaffSpace * spaceWidth
        let width = self.aspectRatio * height
        return CGSize(width: width, height: height)
    }
    
    func bounds(withSpaceWidth spaceWidth: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint.zero, size: self.size(withSpaceWidth: spaceWidth))
    }
    
    func offset(in clef: MusicClef) -> Int {
        return 0
    }
    
    func direction(in clef: MusicClef) -> MusicStaffViewElementDirection {
        return .up
    }
    
    var accessoryElements: [MusicStaffViewAccessory]? {
        return nil
    }
}
