//
//  MusicNote+Drawable.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/17/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicNote: MusicStaffViewDrawable {
    public func layer(atHorizontalPosition: CGFloat) -> MusicStaffViewElementLayer {
        
//            let noteLayer = self.noteLayerFor(note: note, atHorizontalPosition: currentPosition, forcedDirection: i == 0 ? nil : .down)
//            if let accidentalLayer = self.accidentalLayerFor(noteLayer: noteLayer, type: note.accidental) {
//                elementLayers.append(accidentalLayer)
//                currentPosition += accidentalLayer.bounds.width
//            }
//            elementLayers.append(noteLayer)
//            currentPosition += noteLayer.bounds.width
//        }
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
    private func noteLayer(atHorizontalPosition xPosition: CGFloat) -> CAShapeLayer {
        let name = self.pitch.name
        let octave = self.pitch.octave
        let accidental = self.pitch.accidental
        let rhythm = self.rhythm
        
        let noteLayer = CAShapeLayer()
        noteLayer.path = self.quarterNotePath(in: noteLayer.bounds)
        noteLayer.anchorPoint = CGPoint(x: 0.5, y: 0.865)
        
        noteLayer.height = 4.0 * spaceWidth
        noteLayer.position = CGPoint(x: xPosition + noteLayer.bounds.size.width / 2.0, y: self.bounds.size.height)
        
        let offset = -self.displayedClef.offsetForPitch(named: name, octave: octave)
        let viewOffset = viewOffsetForStaffOffset(offset)
        noteLayer.position.y += viewOffset
        
//        var direction = (offset <= 0) ? NoteFlagDirection.down : NoteFlagDirection.up
//        if forcedDirection != nil {
//            direction = forcedDirection!
//        }
        
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
        
        if false {
            noteLayer.backgroundColor = UIColor(red: 0, green: 0, blue: 1.0, alpha: 0.3).cgColor
            ledgerLines?.backgroundColor = UIColor.green.cgColor
        }
        
        return noteLayer
    }
    
    func quarterNotePath(in frame: CGRect) -> CGPath {
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

}
