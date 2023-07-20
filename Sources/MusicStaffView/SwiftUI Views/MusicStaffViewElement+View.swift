//
//  File.swift
//  
//
//  Created by Mike Muszynski on 4/28/22.
//
/*
 This file is filled with empty View protocol declarations along with a single method that allows all of these elements to conform to the protocol.
 
 Currently in Swift, there is no way to extend a protocol such that it will adopt a second protocol, which could then be extended with a default implementation. This is a workaround--the default implementation is provided, and the individual structs declare their conformance without providing any extra implementation.
 */

import SwiftUI
import Music

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicClef: View {}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicNote: View {}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicAccidental: View {}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicPitchAccidental: View {}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicStaffViewElement {
    public var body: some View {
        MusicStaffViewElementShapeView(element: self)
    }
}

struct MusicStaffViewElementShapeView<Element: MusicStaffViewElement>: View {
    @Environment(\.spaceWidth) var spaceWidth: CGFloat
    @Environment(\.clef) var clef: MusicClef
    
    var element: Element
    var body: some View {
        element
            .shape
            .aspectRatio(element.aspectRatio, contentMode: .fit)
            .frame(height: element.heightInStaffSpace * spaceWidth)
            .offset(y: element.heightInStaffSpace * spaceWidth * (0.5 - element.anchorPoint.y))
            .rotationEffect(element.direction(in: clef) == .down ? .degrees(180) : .zero)
    }
}

struct ElementPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            HStack {
                MusicClef.bass
                MusicClef.treble
                MusicClef.alto
                MusicClef.tenor
            }
            .previewDisplayName("Clefs")
            
            HStack {
                MusicAccidental.sharp
                MusicAccidental.flat
            }
            .previewDisplayName("Accidentals")
            
            HStack {
                MusicPitch.c.length(.quarter)
                MusicPitch.c.length(.half)
                MusicPitch.c.length(.whole)
                Group {
                    MusicPitch.c.length(.quarter)
                    MusicPitch.c.length(.half)
                    MusicPitch.c.length(.whole)
                }.environment(\.clef, .bass)
            }
            .previewDisplayName("Notes")
        }
        .previewLayout(.fixed(width: 400, height: 100))
        .environment(\.spaceWidth, 10)
    }
}
