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

public enum MusicStaffViewElementJustification {
    case centered
    case leftJustified
    case rightJustified
}

public protocol MusicStaffViewElement {
    /// The path that describes the shape of the element in the element's bounding box. This should be used in concert with `aspectRatio` and `heightInStaffSpace` to determine the actual shape and size of the bounding box when drawing.
    func path(in frame: CGRect) -> CGPath
    
    /// Returns a CALayer containing the element to be drawn.
    ///
    /// - Parameter spaceWidth: The width of the spaces between the lines of the staff.
    /// - Returns: The layer to be drawn by `MusicStaffView`
    func layer(in clef: MusicClef, withSpaceWidth spaceWidth: CGFloat, color: CGColor) -> CALayer
    
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
    
    /// The distance in staff positions that the element is drawn from the center line, given a specific clef. For example, in Bass Clef, the note E3 would be drawn one position higher than the middle line and would need to return +1 from this function.
    ///
    /// - Parameter clef: The cleff that is currently active in the `MusicStaffView`
    /// - Returns: Number of positions from the middle staff line
    func offset(in clef: MusicClef) -> Int
    
    
    /// The direction that the element should be drawn, either upward or downward.
    ///
    /// - Parameter clef: The cleff that is currently active use in the `MusicStaffView`
    /// - Returns: Either `MusicStaffViewElementDirection.up` or `MusicStaffViewElementDirection.down`
    func direction(in clef: MusicClef) -> MusicStaffViewElementDirection
    
    /// Instructs the `MusicStaffView` to unmask the ledger lines beneath the element's layer.
    ///
    /// - Parameter clef: The cleff that is currently active use in the `MusicStaffView`
    /// - Returns: True if the element requires ledger lines, false if not
    func requiresLedgerLines(in clef: MusicClef) -> Bool
    
    /// Any `MusicStaffViewAccessory` elements that should be drawn.
    var accessoryElements: [MusicStaffViewAccessory]? { get }
 
    /// Minimum spacing in terms of percentage of the size of the element
    var minimumSpacing: (leading: CGFloat, trailing: CGFloat) { get }
}

extension MusicStaffViewElement {
    public func layer(in clef: MusicClef, withSpaceWidth spaceWidth: CGFloat, color: CGColor) -> CALayer {
        let frame = self.bounds(withSpaceWidth: spaceWidth)
        let layer = CAShapeLayer()
        layer.bounds = frame
        layer.path = self.path(in: frame)
        layer.anchorPoint = self.anchorPoint
        layer.fillColor = color
        
        let offset = self.offset(in: clef)
        layer.position.y -= CGFloat(offset) * spaceWidth / 2.0
            
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
    
    public func offset(in clef: MusicClef) -> Int {
        return 0
    }
    
    public var anchorPoint: CGPoint {
        return CGPoint(x: 0.5, y: 0.5)
    }
    
    public func direction(in clef: MusicClef) -> MusicStaffViewElementDirection {
        return .up
    }
    
    public var accessoryElements: [MusicStaffViewAccessory]? {
        return nil
    }
    
    public var minimumSpacing: (leading: CGFloat, trailing: CGFloat) {
        return (leading: 0, trailing: 0)
    }
    
    public func requiresLedgerLines(in clef: MusicClef) -> Bool {
        return false
    }
    
    public var justification: MusicStaffViewElementJustification {
        return MusicStaffViewElementJustification.centered
    }
}
