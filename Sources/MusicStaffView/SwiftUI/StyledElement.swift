//
//  File.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/10/26.
//

import Foundation
import CoreGraphics
import SwiftUI
import Music

public struct MusicStaffViewStyledElement<E: MusicStaffViewElement>: MusicStaffViewElement {
    let element: E
    public let style: AnyShapeStyle?
    
    public func path(in frame: CGRect) -> CGPath {
        element.path(in: frame)
    }
    
    public var aspectRatio: CGFloat { element.aspectRatio }
    public var heightInStaffSpace: CGFloat { element.heightInStaffSpace }
    public func offset(in clef: MusicClef) -> Int {
        element.offset(in: clef)
    }
    public func direction(in clef: MusicClef) -> MusicStaffViewElementDirection {
        element.direction(in: clef)
    }
    public var anchorPoint: CGPoint {
        element.anchorPoint
    }
}

extension MusicStaffViewElement {
    public func foregroundStyle(_ style: any ShapeStyle) -> MusicStaffViewStyledElement<Self> {
        MusicStaffViewStyledElement(element: self, style: AnyShapeStyle(style))
    }
}

#Preview {
    MusicStaffView(clef: .bass) {
        MusicPitch.c.octave(3).quarter
            .foregroundStyle(.purple)
        MusicPitch.d.octave(3).quarter
            .foregroundStyle(.indigo)
        MusicPitch.e.octave(3).quarter
            .foregroundStyle(.blue)
        MusicPitch.f.octave(3).quarter
            .foregroundStyle(.green)
        MusicPitch.g.octave(3).quarter
            .foregroundStyle(.yellow)
        MusicPitch.a.octave(3).quarter
            .foregroundStyle(.orange)
        MusicPitch.b.octave(3).quarter
            .foregroundStyle(.red)
    }
    .staffStyle(.primary)
}
