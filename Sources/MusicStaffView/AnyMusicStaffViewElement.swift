//
//  AnyMusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/24/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music
import QuartzCore

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

internal protocol _MusicStaffViewElementBox {
    var unboxed: MusicStaffViewElement { get }
    
    /// The path that describes the shape of the element in the element's bounding box. This should be used in concert with `aspectRatio` and `heightInStaffSpace` to determine the actual shape and size of the bounding box when drawing.
    func path(in frame: CGRect) -> CGPath
    
    /// Returns a CALayer containing the element to be drawn.
    ///
    /// - Parameter spaceWidth: The width of the spaces between the lines of the staff.
    /// - Returns: The layer to be drawn by `MusicStaffView`
    func layer(in clef: MusicClef, withSpaceWidth spaceWidth: CGFloat, color: ColorType?) -> CALayer
    
    /// Provides a default color
    var color: ColorType { get }

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
    /// - Returns: The number of ledger lines required in the clef (positive above, negative below) or 0 if none are required.
    func requiredLedgerLines(in clef: MusicClef) -> Int
    
    /// Instructs the `MusicStaffView` to unmask the ledger lines beneath the element's layer.
    ///
    /// - Parameter clef: The cleff that is currently active use in the `MusicStaffView`
    /// - Returns: True if the element requires ledger lines, false if not.
    func requiresLedgerLines(in clef: MusicClef) -> Bool
    
    /// Any `MusicStaffViewAccessory` elements that should be drawn.
    var accessoryElements: [MusicStaffViewAccessory] { get }
 
    /// Minimum spacing in terms of percentage of the size of the element
    var minimumSpacing: (leading: CGFloat, trailing: CGFloat) { get }
    
}

struct ConcreteAnyMusicStaffViewElementBox<Base: MusicStaffViewElement>: _MusicStaffViewElementBox {
    
    let base: Base
    
    var unboxed: MusicStaffViewElement {
        return base as MusicStaffViewElement
    }
    
    var accessoryElements: [MusicStaffViewAccessory] { return base.accessoryElements }
    
    var minimumSpacing: (leading: CGFloat, trailing: CGFloat) { return base.minimumSpacing }

    func path(in frame: CGRect) -> CGPath {
        return base.path(in: frame)
    }
    
    var aspectRatio: CGFloat {
        return base.aspectRatio
    }
    
    var heightInStaffSpace: CGFloat {
        return base.heightInStaffSpace
    }
    
    var anchorPoint: CGPoint {
        return base.anchorPoint
    }
    
    func offset(in clef: MusicClef) -> Int {
        return base.offset(in: clef)
    }
    
    func direction(in clef: MusicClef) -> MusicStaffViewElementDirection {
        return base.direction(in: clef)
    }
    
    func layer(in clef: MusicClef, withSpaceWidth spaceWidth: CGFloat, color: ColorType?) -> CALayer {
        base.layer(in: clef, withSpaceWidth: spaceWidth, color: color)
    }
    
    var color: ColorType {
        return base.color
    }
    
    func requiredLedgerLines(in clef: MusicClef) -> Int {
        return base.requiredLedgerLines(in: clef)
    }
    
    func requiresLedgerLines(in clef: MusicClef) -> Bool {
        return base.requiresLedgerLines(in: clef)
    }
    
}

struct AnyMusicStaffViewElement: MusicStaffViewElement {
    private let box: _MusicStaffViewElementBox
    let uuid = UUID()
    
    init<T: MusicStaffViewElement>(_ object: T) {
        box = ConcreteAnyMusicStaffViewElementBox(base: object)
    }
    
    var unboxed: MusicStaffViewElement {
        return box.unboxed
    }
    
    func path(in frame: CGRect) -> CGPath {
        return box.path(in: frame)
    }
    
    var aspectRatio: CGFloat {
        return box.aspectRatio
    }
    
    var heightInStaffSpace: CGFloat {
        return box.heightInStaffSpace
    }
    
    var anchorPoint: CGPoint {
        return box.anchorPoint
    }
    
    func offset(in clef: MusicClef) -> Int {
        return box.offset(in: clef)
    }
    
    func direction(in clef: MusicClef) -> MusicStaffViewElementDirection {
        return box.direction(in: clef)
    }
    
    var accessoryElements: [MusicStaffViewAccessory] {
        return box.accessoryElements
    }
}

extension MusicStaffViewElement {
    var asAnyMusicStaffViewElement: AnyMusicStaffViewElement {
        AnyMusicStaffViewElement(self)
    }
}
