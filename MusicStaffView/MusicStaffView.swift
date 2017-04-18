//
//  MusicStaffView.swift
//  Music
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

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
    private var _noteArray: [MusicStaffViewNote] = [] {
        didSet {
            setupLayers()
        }
    }
    
    ///Provides an array of `MusicStaffViewNote` objects that represent the notes to be displayed in the `MusicStaffView`.
    ///
    ///The notes represented on a the `MusicStaffView` are represented by `MusicStafffViewNote` objects that describe the position and length of each note, along with any accidentals necessary to draw.
    public var noteArray: [MusicStaffViewNote] {
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
    @IBInspectable var maxLedgerLines : Int = 0 {
        didSet {
            self.setupLayers()
        }
    }
    
    ///The preferred horizontal spacing, in points, between horizontal staff elements, such as notes, accidentals, clefs and key signatures.
    @IBInspectable var preferredHorizontalSpacing : CGFloat = 0 {
        didSet {
            self.setupLayers()
        }
    }
    
    ///The clef to display, wrapped in an `ClefType` enum.
    @IBInspectable var displayedClef : MusicClefType = .treble {
        didSet{
            self.setupLayers()
        }
    }
    
    ///Whether or not to draw the frames for each of the elements drawn in the staff.
    ///
    ///When set to true, this will draw bright, semi-transparent boxes in the frames of each of the layers representing a staff element.
    @IBInspectable var debug : Bool = true {
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
    var staffLayer : MusicStaffViewStaffLayer
    
    //Required initializer to make sure the `MusicStaffViewStaffLayer` is defined as it is not an optional.
    required public init(coder aDecoder: NSCoder) {
        staffLayer = MusicStaffViewStaffLayer()
        super.init(coder: aDecoder)!
    }
    
    //Required initializer to make sure the `MusicStaffViewStaffLayer` is defined as it is not an optional. Calls the layer setup function as well.
    override init(frame: CGRect) {
        staffLayer = MusicStaffViewStaffLayer()
        super.init(frame: frame)
        self.setupLayers()
    }
    
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
        staffLayer.removeFromSuperlayer()
        staffLayer = MusicStaffViewStaffLayer()
        self.drawStaff(in: self.bounds)
        self.draw(clef: displayedClef, atHorizontalPosition: 0.0)
        
        //the layers representing the horizontal elements to be drawn
        //decoration elements will have to be dealt with at a later date
        var elementLayers = [MusicStaffViewElementLayer]()
        //previously, the notes were drawn sequentially
        //the staff layer kept up-to-date with where the last element ended and the next should begin
        //setupLayers() needs to keep up with this now
        //the current position of the staff after drawing the clef is the first place to draw a note
        var currentPosition = staffLayer.currentHorizontalPosition
        
        for i in 0..<noteArray.count {
            currentPosition += preferredHorizontalSpacing
            let note = noteArray[i]
            let noteLayer = self.noteLayerFor(note: note, atHorizontalPosition: currentPosition, forcedDirection: i == 0 ? nil : .down)
            if let accidentalLayer = self.accidentalLayerFor(noteLayer: noteLayer, type: note.accidental) {
                elementLayers.append(accidentalLayer)
                currentPosition += accidentalLayer.bounds.width
            }
            elementLayers.append(noteLayer)
            currentPosition += noteLayer.bounds.width
        }
        
        //if the spacing is set to uniform, there needs to be a calculation done to make the notes equally spaced:
        //1. get the position of the first note as it is the leftmost bound
        //1a. alternatively, the staffLayer.currentHorizontalPosition will work
        //2. sum the widths of the notes
        //3. subtract this sum from the width of the view
        //4. divide this by the number of spaces between notes
        //4a. note that there are spacers between each note and one on either side for a total of noteLayer.count + 1
        if self.spacing == .uniform {
            let leftmostBound = staffLayer.currentHorizontalPosition
            let widthSum = elementLayers.reduce(CGFloat(0), { (collection, layer) -> CGFloat in
                return collection + layer.bounds.width
            })
            let drawableWidth = staffLayer.bounds.width - leftmostBound
            let spacerCount = elementLayers.filter({ (layer) -> Bool in
                if case .accidental(_) = layer.type {
                    return false
                }
                return true
            }).count + 1
            let spacerWidth = (drawableWidth - widthSum) / CGFloat(spacerCount)
            
            currentPosition = leftmostBound + spacerWidth
            for layer in elementLayers {
                layer.frame.origin.x = currentPosition
                staffLayer.addSublayer(layer)
                currentPosition += layer.bounds.width
                if case .note(_) = layer.type {
                    currentPosition += spacerWidth
                }
                
            }
        } else {
            for layer in elementLayers {
                staffLayer.addSublayer(layer)
            }
        }
        

        
    }
    
    ///Draws the five lines of the musical staff in the appropriate rectangle. In general, this rectangle is the bounds of the `MusicStaffView` but could eventually be customized.
    private func drawStaff(in rect: CGRect) {
        staffLayer.frame = rect
        staffLayer.maxLedgerLines = self.maxLedgerLines
        if debug {
            staffLayer.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.25).cgColor
        }
        self.layer.addSublayer(staffLayer)
    }
    
    ///Draws the clef at the proper position.
    ///
    ///Currently, this is hardcoded to draw the treble clef at the far left of the staff.
    private func draw(clef type: MusicClefType, atHorizontalPosition xPosition: CGFloat) {
        //FIXME: Allow for the drawing of other clefs
        let clefLayer = MusicStaffViewElementLayer(type: .clef(type))
        clefLayer.height = 6.5 * spaceWidth
        clefLayer.position = CGPoint(x: xPosition, y: self.bounds.size.height / 2.0 + spaceWidth)
        staffLayer.addSublayer(clefLayer)
    }
    
    ///Convenience method to adopt Swift 3.0 conventions
    private func draw(note: MusicStaffViewNote, atHorizontalPosition xPosition: CGFloat, forcedDirection: NoteFlagDirection?) {
        let noteLayer = self.noteLayerFor(note: note, atHorizontalPosition: xPosition, forcedDirection: forcedDirection)
        staffLayer.addSublayer(noteLayer)
    }
    
    ///Intitializes a note at a given horizontal position in the staff.
    ///
    ///This method is used by `setupLayers()` to initialize a `MusicStaffViewElementLayer` proper notational attributes at a suggested horizontal position. Specifically, the method calculates where to place the note vertically with respect to the currently selected clef given its name and octave.
    ///
    ///The method creates a new `MusicStaffViewElementLayer`, positions it properly and finally adds accidentals and ledger lines as necessary to complete the visual presentation of a note at the appropriate position in the staff.
    ///
    ///- note: It is possible to force a note to be drawn in a particular direction (e.g. up or down) by using the forcedDirection attribute. As of yet, this is untested and may result in undefined behavior, most likely ledger lines or accidentals in incorrect places.
    ///
    ///- note: Previously, this method was used to actually draw the note in place. In order to best space notes equally, it makes sense to create the layer, but postpone the positioning until the full width of all notes in the view is known. See `setuplayers()` for more information.
    ///
    ///- parameter name: The name of the note
    ///- parameter octave: The octave of the note
    ///- parameter accidental: The `AccidentalType` to draw, including `AccidentalType.none` if there should be no accidental
    ///- parameter length: The length of note to be drawn
    ///- parameter atHorizontalPosition: The horizontal position, in points, at which to draw the left edge of the note
    ///- parameter forcedDirection: The direction, up or down, to force the note (see note above)
    private func noteLayerFor(note: MusicStaffViewNote, atHorizontalPosition xPosition: CGFloat, forcedDirection: NoteFlagDirection?) -> MusicStaffViewElementLayer {
        let name = note.name
        let octave = note.octave
        let accidental = note.accidental
        let length = note.length
        
        let noteLayer = MusicStaffViewElementLayer(type: .note(name, accidental, length))
        
        noteLayer.height = 4.0 * spaceWidth
        noteLayer.position = CGPoint(x: xPosition + noteLayer.bounds.size.width / 2.0, y: self.bounds.size.height)
        
        let offset = -self.displayedClef.offsetForPitch(named: name, octave: octave)
        let viewOffset = viewOffsetForStaffOffset(offset)
        noteLayer.position.y += viewOffset
        
        var direction = (offset <= 0) ? NoteFlagDirection.down : NoteFlagDirection.up
        if forcedDirection != nil {
            direction = forcedDirection!
        }
        
        //default direction is up
        if direction == .up {
            noteLayer.transform = CATransform3DIdentity
        } else {
            noteLayer.anchorPoint = CGPoint(x: 0.5, y: 0.62)
            noteLayer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 0, 1.0)
        }
        
        //draw ledger lines if necessary
        var ledgerLines: CALayer?
        let ledger = ledgerLinesForStaffOffset(offset)
        if ledger.count > 0 {
            ledgerLines = CALayer()
            
            //hopefully
            for i in 0..<ledger.count {
                let currentLedgerLine = CAShapeLayer()
                currentLedgerLine.bounds = CGRect(x: 0, y: 0, width: noteLayer.bounds.size.width - 2.0, height: staffLayer.lineWidth * 3.0)
                currentLedgerLine.backgroundColor = UIColor.black.cgColor
                currentLedgerLine.position.y += noteLayer.anchorPoint.y * noteLayer.bounds.size.height - CGFloat(i) * spaceWidth
                currentLedgerLine.position.x += noteLayer.anchorPoint.x * noteLayer.bounds.size.width
                
                if !ledger.centered {
                    currentLedgerLine.position.y -= (direction == .up) ? spaceWidth / 2.0 : -spaceWidth / 2.0
                }
                
                currentLedgerLine.strokeColor = UIColor.black.cgColor
                ledgerLines?.addSublayer(currentLedgerLine)
            }
            
            noteLayer.addSublayer(ledgerLines!)
        }
        
        if debug {
            noteLayer.backgroundColor = UIColor(red: 0, green: 0, blue: 1.0, alpha: 0.3).cgColor
            ledgerLines?.backgroundColor = UIColor.green.cgColor
        }
        
        return noteLayer
    }
    
    func accidentalLayerFor(noteLayer: MusicStaffViewElementLayer, type: MusicPitchAccidental) -> MusicStaffViewElementLayer? {
        let accidentalLayer: MusicStaffViewElementLayer
        let accidental = type
        
        guard accidental != .none else {
            return nil
        }
        
        accidentalLayer = MusicStaffViewElementLayer(type: .accidental(accidental))
        accidentalLayer.height = 0.70 * 4.0 * spaceWidth
        accidentalLayer.position = noteLayer.position
        
        if debug {
            accidentalLayer.backgroundColor = UIColor(red: 0, green: 1.0, blue: 1.0, alpha: 0.3).cgColor
        }
        return accidentalLayer
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
    
    ///The number of ledger lines necessary for a note at a given staff offset.
    ///
    ///When a note is far enough from the center line of the staff, it will be necessary to draw ledger lines to represent how much outside the staff it lays.
    ///
    ///- parameter offset: The number of positions above or below the middle line where the note resides
    ///
    ///- returns: A tuple with the number of ledger lines and a boolean representing whether or not they are centered on the notehead
    private func ledgerLinesForStaffOffset(_ offset: Int) -> (count: Int, centered: Bool) {
        if abs(offset) < 6 {
            return (0, false)
        }
    
        return ((abs(offset) - 4) / 2, offset % 2 == 0)
    }
        
    override public func prepareForInterfaceBuilder() {
        self.setupLayers()
    }

}
