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
/// **Values**
/// - *preferred*: Elements are drawn according to the `preferredHorizontalSpacing` attribute
/// - *uniformFullWidth*: Elements are drawn an equal width from each other, with no spacing at either margin
/// - *uniformTrailingSpace*: Elements are drawn an equal width from each other, with another equal space at the trailing edge
/// - *uniformLeadingAndTrailingSpace*: Elements are drawn an equal width from each other, with equal spacing at the leading and trailing edges
///
///For certain uses, notes on a staff should be drawn to maximize all available space. In other cases (for example, when the notes will take up more space than the visible area of the view itself), it makes sense to draw the notes as close together as possible. These scenarios are represented in `MusicStaffViewSpacingType` as `preferred`, which uses the `preferredHorizontalSpacing` property, or `uniform`, which discards the property in favor of spacing notes equally across the view.
///
///- Warning: There may be cases where using uniform spacing will still cause notes to be drawn outside the visible area of the `MusicStaffView`. Currently, the framework takes no position in these situations.
public enum MusicStaffViewSpacingType {
    //FIXME: What happens when spacing causes notes to draw past the bounds of the view?
    case preferred
    case uniformFullWidth
    case uniformTrailingSpace
    case uniformLeadingAndTrailingSpace
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
    
    ///Private backing array for `elementArray`.
    private var _elementArray: [MusicStaffViewElement] = [] {
        didSet {
            setupLayers()
        }
    }
    
    ///Provides an array of `MusicStaffViewNote` objects that represent the notes to be displayed in the `MusicStaffView`.
    ///
    ///The notes represented on a the `MusicStaffView` are represented by `MusicStafffViewNote` objects that describe the position and length of each note, along with any accidentals necessary to draw.
    public var elementArray: [MusicStaffViewElement] {
        get {
            #if TARGET_INTERFACE_BUILDER
                var testArray = [MusicStaffViewNote]()
                testArray.append(MusicStaffViewNote(name: .c, accidental: .sharp, length: .quarter, octave: 4))
                return testArray
            #else
                return _elementArray
            #endif
        }
        set {
            _elementArray = newValue
        }
    }
    
    ///The maximum number of ledger lines to be drawn within the `MusicStaffView`.
    @IBInspectable public var maxLedgerLines : Int = 0 {
        didSet {
            self.setupLayers()
        }
    }
    
    ///The preferred horizontal spacing, in points, between horizontal staff elements, such as notes, accidentals, clefs and key signatures.
    @IBInspectable public var preferredHorizontalSpacing : CGFloat = 0.0 {
        didSet {
            self.setupLayers()
        }
    }
    
    ///The clef to display, wrapped in an `ClefType` enum.
    public var displayedClef : MusicClef = .treble
    
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
    public var drawAllAccidentals : Bool = false
    
    ///Instructs whether to fill all available space by using uniform spacing or to draw the clef information and then fill in the notes using `preferredHorizontalSpacing`.
    ///
    ///

    public var spacing: MusicStaffViewSpacingType = .preferred {
        didSet {
            self.setupLayers()
        }
    }
    
    //The staff layer that is drawn
    var staffLayer = MusicStaffViewStaffLayer()
    var elementDisplayLayer = CALayer()
    
    /// The color that the staff should be drawn
    public var staffColor: UIColor = UIColor.black
    public var elementColor: UIColor = UIColor.black
    
    ///Redraws all elements of the `MusicStaffView`, first removing them if they are already drawn.
    ///
    ///This method does the drawing of the various elements of the musical staff. It is not necessary to call this function manually, as it is called when the various different layer properties are updated (e.g. when the clef type is changed, the view will be redrawn using this method).
    ///
    ///In order to fully set up the layers, `MusicStaffView` keeps track of the various `MusicStaffViewElement` objects, asks them for a CALayer that describes their appearance, and applies a best-guess position horizontally. This position is then refined, based on the spacing settings and the properties of the elements themselves. In general, the elements that are drawn have strict vertical position requirements (i.e. they represent notes on a staff and changing their position would change their meaning), but it is possible that there will be further elements that need some refinement in the vertical direction.
    ///
    func setupLayers() {
        //remove the element and staff layers and initialize them with new instances
        staffLayer.removeFromSuperlayer()
        staffLayer = MusicStaffViewStaffLayer()
        staffLayer.frame = self.bounds
        
        elementDisplayLayer.removeFromSuperlayer()
        elementDisplayLayer = CALayer()
        elementDisplayLayer.frame = self.bounds
        
        //Get the elements to draw, currently just clef and notes
        var elements = [MusicStaffViewElement]()
        
        //Make the elements from their various sub-elements and shims.
        //Basically, put a flexible shim in between every element
        //Make the shims static if necessary
        for element in elementArray {
            //Does the element have accessories?
            if let accessories = element.accessoryElements {
                
                //Iterate through each accessory and figure out how to place it
                for accessory in accessories {
                    switch accessory.placement {
                        
                    //Above and Below are potentially beyond the scope of this horizontal spacing regime
                    //Standalone may be, but there may also not be a need for standalone at all.
                    case .above, .below, .standalone:
                        fatalError("These are not yet implemented")
                        
                    //Leading elements precede their parent elements. They require an static shim after themselves.
                    //Note that shims are not flexible by default
                    case .leading:
                        elements.append(accessory)
                        let shim = MusicStaffViewShim(width: preferredHorizontalSpacing, spaceWidth: spaceWidth)
                        elements.append(shim)
                        
                    //Trailing elements follow their parent elements.
                    //These are more difficult, because the parent elements will draw a flexible shim after themselves.
                    //This shim needs to be captured and then made static.
                    case .trailing:
                        if var lastShim = elements.last as? MusicStaffViewShim {
                            lastShim.isFlexible = false
                            lastShim.width = preferredHorizontalSpacing
                        }
                        elements.append(accessory)
                        var flexShim = MusicStaffViewShim(width: 0.0, spaceWidth: spaceWidth)
                        flexShim.isFlexible = true
                        elements.append(flexShim)
                    }
                }
            }
            
            //Finally, add the elements themselves
            elements.append(element)
            //And a flexible shim
            var flexShim = MusicStaffViewShim(width: 0.0, spaceWidth: spaceWidth)
            flexShim.isFlexible = true
            elements.append(flexShim)
        
        }
        
        //now that all of the elements are decided, sum their widths:
        let totalElementWidth = elements.reduce(0.0) { (total, nextElement) -> CGFloat in
            return total + nextElement.layer(in: displayedClef, withSpaceWidth: spaceWidth, color: nil).bounds.size.width
        }
        
        //get the amount of the view that will be unused space in the end
        let viewWidth = self.bounds.size.width
        let extraWidth = viewWidth - totalElementWidth
        
        //sum up the number of flexible shims
        let numFlexible = elements.filter { (element) -> Bool in
            guard let shim = element as? MusicStaffViewShim else {
                return false
            }
            return shim.isFlexible
        }.count
        
        //come up with the width of each shim, ensuring that it will be positive.
        //at this point, it just bails out to preferred if it is not positive.
        //there's also a sanity check in case the numFlexible is equal to zero.
        var flexWidth: CGFloat = preferredHorizontalSpacing
        
        if elements.count > 0 {
            if numFlexible == 0 || extraWidth < 0 {
                print("There were either zero flexible elements or their widths would be negative. Reverting to preferred horizontal spacing.")
                flexWidth = preferredHorizontalSpacing
            } else {
                flexWidth = extraWidth / CGFloat(numFlexible)
            }
        }
        
        //Reserve an array for the guessed positions of the elements
        var elementHorizontalPositions = [CGFloat]()
        
        //Reserve an array for the layers that are going to be drawn
        var elementLayers = [CALayer]()
        
        //Reserve an array for whether the layer has ledger lines to be unmasked
        var ledgerLineElementIndices = [Int]()
        
        //the current horizontal position begins at zero
        //MusicStaffView must keep track of the spacing, and likely will to due layouts and constraints
        var currentPosition: CGFloat = 0.0
        
        //iterate through the elements and add its CAShapeLayer to the array of layers to be drawn
        //move the current position accordingly
        for element in elements {
            //if the clef has changed, update the current display clef that makes calculations work
            if let newClef = element as? MusicClef {
                self.displayedClef = newClef
            }
            
            let layers: [CALayer]
            if var element = element as? MusicStaffViewShim, element.isFlexible {
                element.width = flexWidth
                layers = self.layers(for: element, atHorizontalPosition: currentPosition)
            } else {
                layers = self.layers(for: element, atHorizontalPosition: currentPosition)
            }
            
            elementLayers.append(contentsOf: layers)
            currentPosition = (elementLayers.last?.frame.origin.x ?? 0) + (elementLayers.last?.frame.size.width ?? 0)
            if element.requiresLedgerLines(in: self.displayedClef) {
                ledgerLineElementIndices.append(elementHorizontalPositions.count)
            }
            elementHorizontalPositions.append(currentPosition)
        }
                
        //This is old spacing information
        //
        //
//        //currently, the elements are drawn with no spacing, so spacing must be added
//        //what is the width of all elements?
//        let elementWidth = elementLayers.reduce(0.0) { (result, layer) -> CGFloat in
//            return result + layer.bounds.size.width
//        }
//
//        //adds a uniform spacing between each element
//        func addUniformSpacing(of amount: CGFloat, omitFirst: Bool = true) {
//            for (count, layer) in elementLayers.enumerated() {
//                var moveCount = CGFloat(count)
//                if !omitFirst { moveCount += 1.0 }
//                layer.position.x += amount * moveCount
//                if let ledgerIndex = ledgerLineElementIndices.index(of: count) {
//                    self.staffLayer.unmaskRects[ledgerIndex].origin.x += amount * moveCount
//                }
//            }
//        }
//
//        switch self.spacing {
//        case .preferred:
//            addUniformSpacing(of: preferredHorizontalSpacing)
//        case .uniformFullWidth:
//            let spacing: CGFloat
//            if elementLayers.count - 1 == 0 {
//                //print("not enough elements to use this spacing. Falling back to preferred spacing.")
//                spacing = preferredHorizontalSpacing
//            } else {
//                //print("using uniform full width spacing.")
//                spacing = (self.bounds.size.width - elementWidth) / CGFloat(elementLayers.count - 1)
//            }
//            addUniformSpacing(of: spacing)
//        case .uniformTrailingSpace:
//            let spacing: CGFloat
//            if elementLayers.count == 0 {
//                //print("not enough elements to use this spacing. Falling back to preferred spacing.")
//                spacing = preferredHorizontalSpacing
//            } else {
//                //print("using uniform trailing spacing.")
//                spacing = (self.bounds.size.width - elementWidth) / CGFloat(elementLayers.count)
//            }
//            addUniformSpacing(of: spacing)
//        case .uniformLeadingAndTrailingSpace:
//            let spacing = (self.bounds.size.width - elementWidth) / CGFloat(elementLayers.count + 1)
//            addUniformSpacing(of: spacing, omitFirst: false)
//        }
        
        
        //add the element layers to the element display layer
        for layer in elementLayers {
            self.elementDisplayLayer.addSublayer(layer)
        }
        
        //Draw the staff lines, including ledger lines
        //Unnecessary ledger lines are masked out later
        staffLayer.maxLedgerLines = self.maxLedgerLines
        let mask = staffLayer.staffLineMask!
        if debug {
            mask.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.5).cgColor
            staffLayer.backgroundColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.25).cgColor
            staffLayer.addSublayer(mask)
        }
        
        //mask out the unnecessary ledger lines
        staffLayer.strokeColor = staffColor.cgColor
        staffLayer.mask = mask
        
        self.layer.addSublayer(staffLayer)
        self.layer.addSublayer(elementDisplayLayer)
    }
    
    private func layers(for element: MusicStaffViewElement, atHorizontalPosition xPosition: CGFloat) -> [CALayer] {
        var elementLayers = [CALayer]()
        var layer = element.layer(in: displayedClef, withSpaceWidth: self.spaceWidth, color: self.elementColor)
        
        if debug {
            layer.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0, alpha: 0.25).cgColor
        }
        
        if element is MusicStaffViewShim {
            layer = element.layer(in: displayedClef, withSpaceWidth: self.spaceWidth, color: UIColor.clear)
        }
        
        if element.direction(in: self.displayedClef) == .down {
            layer.transform = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 0, 1.0)
        }
        
        var elementPosition = layer.position
        elementPosition.x = xPosition
        elementPosition.y += self.bounds.size.height / 2.0

        //i don't think that accessories need to be drawn anymore.
//        //are there any accessories, such as sharps or flats?
//        //add them to the array to lay out
//        if let accessories = element.accessoryElements {
//            for accessory in accessories {
//
//                //do not draw accidentals unless drawAllAccidentals is true
//                guard !((accessory as? MusicAccidental) == .natural && !drawAllAccidentals) else {
//                    continue
//                }
//
//                let accessoryLayer = accessory.layer(in: displayedClef, withSpaceWidth: self.spaceWidth, color: self.elementColor)
//                switch accessory.placement {
//                case .leading:
//                    //reposition elementPosition so that x value is now 0 + half width of accessory layer
//                    elementPosition.x += accessoryLayer.bounds.width * 0.5
//                    accessoryLayer.position = elementPosition
//
//                    //reposition elementPosition so that x is now at the full extent of the accessory layer
//                    //then add element spacing and width of element
//                    elementPosition.x += accessoryLayer.bounds.width * 0.5
//
//                    //add the accessory element to the display layers
//                    elementLayers.append(accessoryLayer)
//                default:
//                    fatalError()
//                }
//            }
//        }
        
        //print(element)
        //print(element.offset(in: displayedClef))
        //print(elementPosition)
        elementPosition.x += layer.bounds.width * 0.5
        layer.position = elementPosition
        
        //this is key. if the element requires ledger lines, they need to be unmasked in the staff layer
        func extensionFromCenterLine(for rect: CGRect, fullHeight: Bool) -> CGRect {
            let centerLine = self.bounds.midY
            let minY = rect.minY + (fullHeight ? 0 : self.staffLayer.lineWidth)
            let maxY = rect.maxY
            
            let rectSize = CGSize(width: rect.size.width, height: self.spaceWidth * 4.0)
            let rectOrigin = CGPoint(x: rect.origin.x, y: centerLine - self.spaceWidth * 2.0)
            var extentsRect = CGRect(origin: rectOrigin, size: rectSize)
                        
            if minY < centerLine - spaceWidth * 2.0 {
                extentsRect.origin.y = minY
                extentsRect.size.height += centerLine - self.spaceWidth * 2.0 - minY
            }
                        
            if maxY > centerLine + spaceWidth * 2.0 {
                extentsRect.size.height += maxY - (centerLine + spaceWidth * 2.0) - (fullHeight ? 0 : self.staffLayer.lineWidth)
            }
            
            return extentsRect
        }
        
        if element.requiresLedgerLines(in: self.displayedClef) {
            let maskRect = extensionFromCenterLine(for: layer.frame, fullHeight: !(element is MusicNote))
            staffLayer.unmaskRects.append(maskRect)
        }
        
        elementLayers.append(layer)

        return elementLayers
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
