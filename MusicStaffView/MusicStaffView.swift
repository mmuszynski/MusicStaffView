//
//  MusicStaffView.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit
import Music

///Instructs the `MusicStaffView` to draw notes using the spacing set in `preferredHorizontalSpacing` or to fill all available space by dividing the space for notes into equal parts.
///
///For certain uses, notes on a staff should be drawn to maximize all available space. In other cases (for example, when the notes will take up more space than the visible area of the view itself), it makes sense to draw the notes as close together as possible. These scenarios are represented in `MusicStaffViewSpacingType` as `preferred`, which uses the `preferredHorizontalSpacing` property, or `uniform`, which discards the property in favor of spacing notes equally across the view.
///
///- Warning: There may be cases where using uniform spacing will still cause notes to be drawn outside the visible area of the `MusicStaffView`. Currently, the framework takes no position in these situations.
public enum MusicStaffViewSpacingType {
    //FIXME: What happens when spacing causes notes to draw past the bounds of the view?
    case preferred
    case uniform
}

@IBDesignable public class MusicStaffView: UIView {
    
    ///The number of notes to be displayed in the interface builder preview.
    ///
    ///Because of limitations in the way interface builder can set user defined values, the values in the `noteArray` are hardcoded. This variable allows for various different numbers of notes to be tested.
    @IBInspectable private var previewNotes: Int = 8 {
        didSet {
            self.setupLayers()
        }
    }
    
    ///Private backing array for `noteArray`.
    private var _noteArray: [MusicNote] = [] {
        didSet {
            setupLayers()
        }
    }
    
    ///Provides an array of `MusicStaffViewNote` objects that represent the notes to be displayed in the `MusicStaffView`.
    ///
    ///The notes represented on a the `MusicStaffView` are represented by `MusicStafffViewNote` objects that describe the position and length of each note, along with any accidentals necessary to draw.
    public var noteArray: [MusicNote] {
        get {
            #if TARGET_INTERFACE_BUILDER
                var testArray = [MusicStaffViewNote]()
                testArray.append(MusicStaffViewNote(name: .c, accidental: .sharp, length: .quarter, octave: 4))
                return testArray
            #else
                return _noteArray
            #endif
        }
        set {
            _noteArray = newValue
        }
    }
    
    ///The maximum number of ledger lines to be drawn within the `MusicStaffView`.
    @IBInspectable public var maxLedgerLines : Int = 0 {
        didSet {
            self.setupLayers()
        }
    }
    
    ///The preferred horizontal spacing, in points, between horizontal staff elements, such as notes, accidentals, clefs and key signatures.
    @IBInspectable public var preferredHorizontalSpacing : CGFloat = 0 {
        didSet {
            self.setupLayers()
        }
    }
    
    ///The clef to display, wrapped in an `ClefType` enum.
    @IBInspectable var displayedClef : MusicClef = .treble {
        didSet{
            self.setupLayers()
        }
    }
    
    ///Whether or not to draw the frames for each of the elements drawn in the staff.
    ///
    ///When set to true, this will draw bright, semi-transparent boxes in the frames of each of the layers representing a staff element.
    @IBInspectable public var debug : Bool = false {
        didSet{
            self.setupLayers()
        }
    }
    
    //Redraw the layers when the bounding rectangle changes
    override public var bounds : CGRect {
        didSet {
            self.setupLayers()
        }
    }
    
    ///The width of each space between two lines on the staff. Read Only.
    ///
    ///
    var spaceWidth : CGFloat {
        get {
            return self.bounds.size.height / (6.0 + 2.0 * CGFloat(maxLedgerLines))
        }
    }
    
    ///Instructs the view to draw all accidentals, even if the `MusicStaffViewNote`'s accidental type is set to none.
    ///
    ///In certain circumstances, it can be helpful to see the accidentals in front of all notes. `MusicStaffView` makes no determinations about accidentals that carry through measures or key signatures.
    var drawAllAccidentals : Bool = false
    
    ///Instructs whether to fill all available space by using uniform spacing or to draw the clef information and then fill in the notes using `preferredHorizontalSpacing`.
    ///
    ///
    public var spacing: MusicStaffViewSpacingType = .uniform
    
    //The staff layer that is drawn
    var staffLayer = MusicStaffViewStaffLayer()
    var elementDisplayLayer = CALayer()
    
    ///Redraws all elements of the `MusicStaffView`, first removing them if they are already drawn.
    ///
    ///This method does the drawing of the various elements of the musical staff. Generally it is not necessary to call this function manually, as it is called when the various different layer elements are updated (e.g. when the clef type is changed, the view will be redrawn using this method).
    ///
    ///Elements are drawn in order of increasing importance, so as to keep the most important items drawn on top. In practice, this is unnecessary, as all elements are currently drawn in the same color, but (as an example) addition of color information would require that certain elements such as notes and accidentals are drawn on top of the staff lines.
    ///
    ///The current order for drawing is as follows:
    ///1. The lines of the staff
    ///2. The clef
    ///3. The individual notes (and the accidentals which are currently attached to the note layer)
    func setupLayers() {
        //remove the element and staff layers and initialize them with new instances
        staffLayer.removeFromSuperlayer()
        staffLayer = MusicStaffViewStaffLayer()
        staffLayer.frame = self.bounds
        
        elementDisplayLayer.removeFromSuperlayer()
        elementDisplayLayer = CALayer()
        elementDisplayLayer.frame = self.bounds
        
        //Get the elements to draw, currently just clef and notes
        let elements: [MusicStaffViewElement] = [displayedClef] + noteArray
        var elementLayers = [CALayer]()
        
        //the current horizontal position begins at zero
        //MusicStaffView must keep track of the spacing, and likely will to do the magnetic layout
        var currentPosition: CGFloat = 0.0
        
        //iterate through the elements and add its CAShapeLayer to the array of layers to be drawn
        //move the current position accordingly
        for element in elements {
            let layer = self.layer(for: element, atHorizontalPosition: currentPosition)
            elementLayers.append(layer)
            currentPosition += (elementLayers.last?.bounds.width ?? 0) + preferredHorizontalSpacing
        }
        
        //add the element layers to the element display layer
        for layer in elementLayers {
            self.elementDisplayLayer.addSublayer(layer)
        }
        
        //Draw the staff lines, including ledger lines
        //Unnecessary ledger lines are masked out later
        staffLayer.maxLedgerLines = self.maxLedgerLines
        if debug {
            staffLayer.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.25).cgColor
        }
        
        //mask out the unnecessary ledger lines
        staffLayer.mask = staffLayer.staffLineMask
        self.layer.addSublayer(staffLayer)
        self.layer.addSublayer(elementDisplayLayer)
        
    }
    
    private func layer(for element: MusicStaffViewElement, atHorizontalPosition xPosition: CGFloat) -> CALayer {
        let elementSize = element.size(withSpaceWidth: self.spaceWidth)
        let elementBounds = CGRect(origin: CGPoint.zero, size: elementSize)
        let layer = element.layer(in: elementBounds)
        
        if element.direction(in: self.displayedClef) == .down {
            layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 0, 1.0)
        }
        
        var elementPosition = CGPoint(x: xPosition + elementSize.width * 0.5, y: self.bounds.size.height / 2.0)
        let offset = element.offset(in: displayedClef)
        elementPosition.y += CGFloat(offset) * spaceWidth / 2.0
        layer.position = elementPosition
        
        //this is key. if the element requires ledger lines, they need to be unmasked in the staff layer
        if element.requiresLedgerLines(in: self.displayedClef) {
            staffLayer.unmaskRects.append(layer.frame)
        }
        
        return layer
    }
    
    ///Translates the staff-based offset (e.g. the number of positions above or below the middle staff line) into a useable metric based on the size of the view.
    ///
    ///This is a convenience method that calculates the actual distance in points represented by a note that is a specific amount of places higher or lower than the middle staff line. For example, an offset of 0 translates to the middle of the view, while an offset of 2, representing the first staff line above the middle line, translates to a specific vertical distance equal to the width between the spaces of the staff.
    ///
    ///- parameter offset: The number of positions above or below the middle line where the note resides
    private func viewOffsetForStaffOffset(_ offset: Int) -> CGFloat {
        let offsetFloat = CGFloat(offset)
        return -self.bounds.size.height / 2.0 + offsetFloat * spaceWidth / 2.0
    }
        
    override public func prepareForInterfaceBuilder() {
        self.setupLayers()
    }

}
