//
//  MusicStaffViewVerticalElementGroup.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 5/16/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

public enum MusicStaffViewVerticalElementGroupJustification {
    case centered, left, right
}

/// A group of `MusicStaffViewElement` objects designed to be placed in the same horizontal location.
public struct MusicStaffViewVerticalElementGroup: RangeReplaceableCollection, MusicStaffViewElement {
    
    //MARK: Collection Protocol
    public typealias _Element = MusicStaffViewElement
    var elements = [_Element]()
    public var startIndex: Int {
        return elements.startIndex
    }
    public var endIndex: Int {
        return elements.endIndex
    }
    public subscript(position: Int) -> _Element {
        return elements[position]
    }
    public func index(after i: Int) -> Int {
        return elements.index(after: i)
    }
    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, C.Iterator.Element == MusicStaffViewVerticalElementGroup._Element {
        elements.replaceSubrange(subrange, with: newElements)
    }
    
    public init() {}
    
    public var shouldDrawLedgerLines: Bool = false
    
    public var justification: MusicStaffViewVerticalElementGroupJustification = .centered
    
    //MARK: MusicStaffViewElement Protocol
    //The following methods of MusicStaffViewElement are unnecessary, as they all are used in creating the CALayer that is given to MusicStaffView. As such, I've set them all to throw fatal errors.
    public func path(in frame: CGRect) -> CGPath {
        fatalError()
    }
    
    public var aspectRatio: CGFloat {
        fatalError()
    }
    
    public var heightInStaffSpace: CGFloat {
        fatalError()
    }
    
    public func requiresLedgerLines(in clef: MusicClef) -> Bool {
        return shouldDrawLedgerLines
    }
    
    //This is the where the group will do the heavy lifting.
    public func layer(in clef: MusicClef, withSpaceWidth spaceWidth: CGFloat, color: CGColor) -> CALayer {
        let multiLayer = CALayer()
        multiLayer.anchorPoint = self.anchorPoint
        
        var layers = [CALayer]()
        for element in self.elements {
            let elementLayer = element.layer(in: clef, withSpaceWidth: spaceWidth, color: color)
            var elementPosition = CGPoint(x: 0, y: 0)
            let offset = element.offset(in: clef)
            elementPosition.y -= CGFloat(offset) * spaceWidth / 2.0
            elementLayer.position = elementPosition
            layers.append(elementLayer)
        }
        
        //find the max width
        let maxWidth = layers.reduce(0.0) { (result, layer) -> CGFloat in
            let width = layer.bounds.width
            return Swift.max(result, width)
        }
        
        //find the highest point, remembering that this is in the negative direction since the iOS view is flipped
        let highestY = layers.reduce(CGFloat.infinity) { (result, layer) -> CGFloat in
            let y = layer.frame.origin.y
            return Swift.min(result, y)
        }
        
        //find the lowest point, remembering that this is in the negative direction since the iOS view is flipped
        let lowestY = layers.reduce(-CGFloat.infinity) { (result, layer) -> CGFloat in
            let y = layer.frame.origin.y + layer.frame.size.height
            return Swift.max(result, y)
        }
        
        //construct the frame and set the bounds of the multilayer
        let multiFrame = CGRect(x: 0, y: 0, width: maxWidth, height: -highestY + lowestY)
        multiLayer.bounds = multiFrame
        
        //move all of the layers such that they are in the appropriate place of the multilayer now
        //this means centering things in an x direction if the justification is centered
        //or putting them the far left or right if they are left or right justified
        //and putting them in the correct y position
        //ypositions should be relative to zero
        //and the multilayer should be positioned where the highest element starts
        //will this break for elements that do not respect the 0.5 x value in anchor point???
        //add them to the multilayer
        for layer in layers {
            layer.position.y -= highestY
            
            switch self.justification {
            case .centered:
                layer.position.x += multiLayer.bounds.size.width / 2.0
            case .left:
                layer.position.x = layer.bounds.size.width / 2.0
            case .right:
                layer.position.x = multiLayer.bounds.size.width - layer.bounds.size.width / 2.0
            }
            
            multiLayer.addSublayer(layer)
        }
                
        return multiLayer
    }
}
