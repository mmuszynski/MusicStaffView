//
//  MusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit
import Music

public enum MusicStaffViewElementType {
    case clef(MusicClef)
    case note(MusicPitch, MusicRhythm)
    case accidental(MusicPitchAccidental)
    case none
}

public enum NoteFlagDirection {
    case up
    case down
}

public protocol MusicStaffViewElement {
    /// The path that describes the shape of the element
    func path(in frame: CGRect) -> CGPath
    func layer(in frame: CGRect) -> CALayer
    
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
}

extension MusicStaffViewElement {
    public func layer(in frame: CGRect) -> CALayer {
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
    
    public func offset(in clef: MusicClef) -> Int {
        return 0
    }
}
