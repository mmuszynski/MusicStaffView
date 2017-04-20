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
    
    /// The type of element to be represented in the view
    ///
    //FIXME: Does this type need to be represented at all?
    //var type: MusicStaffViewElementType { get }
    
    ///The direction that the element should be drawn in a given clef
    func direction(in clef: MusicClef) -> NoteFlagDirection
    
    /// The relative number of positions that the note should be offset from the middle line in the staff.
    ///
    /// - Parameter clef: The clef that is currently being displayed in the `MusicStaffView`
    /// - Returns: The relative positional difference between the center line and the placement of the center of the element
    func offset(in clef: MusicClef) -> Int
    
    /// The path that describes the shape of the element
    func path(in frame: CGRect) -> CGPath
    
    /// The ratio of width to height that describes the general shape of the element's bounding box
    ///
    /// In order to remain resolution-independent, the `MusicStaffView` draws elements in terms of the size they appear relative to the height of spaces in the staff. For example, a quarter note is currently drawn at a height of 4.0 * spaceWidth. This value is used in conjunction with `heightInStaffSpaces` to compute the bounding box for the element.
    var aspectRatio: CGFloat { get }
    
    /// The height, represented as a fraction of one (or more) space widths
    ///
    /// In order to remain resolution-independent, the `MusicStaffView` draws elements in terms of the size they appear relative to the height of spaces in the staff. For example, a quarter note is currently drawn at a height of 4.0 * spaceWidth. This value is used in conjunction with `aspectRatio` to compute the bounding box for the element.
    var heightInStaffSpace: CGFloat { get }
    
    /// The number of ledger lines to draw in a certain clef and whether they should be centered on the anchor point
    func ledgerLines(in clef: MusicClef) -> (count: Int, centered: Bool)
    
    var anchorPoint: CGPoint { get }
}
