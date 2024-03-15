//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI
import Music

/*
 ====================================================
 Generic Element Paths
 ====================================================
 
 The following code allows MusicStaffViewElement objects to be rendered by SwiftUI by creating a Shape to take advantage of the path that each object is required to provide as part of the MusicStaffViewElement protocol
 */

@available(macOS 12, *)
@available(iOS 13, *)
/// Translates the `path` function of the `MusicStaffViewElement` into a specific, but generic `Shape` for use in SwiftUI
///
/// 2022-05-01: I was creating a new shape for every element, and decided instead to try to implement it with a generic `Shape` that could take any type of `MusicStaffViewElement`
struct MusicStaffViewElementShape<Element: MusicStaffViewElement & Sendable>: Shape {
    var element: Element
    init(_ element: Element) { self.element = element }
    func path(in rect: CGRect) -> Path {
        Path(element.path(in: rect))
    }
}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicStaffViewElement {
    /// Returns the generic `Shape` struct to be drawn in SwiftUI
    ///
    /// For more information, see `MusicStaffViewElementShape<Element>` above.
    ///
    /// 2022-05-01: The second of the necessary elements to draw these shapes in SwiftUI, this method extends `MusicStaffViewElement` to take advantage of the generic `Shape` defined in `MusicStaffViewElementShape`
    var shape: MusicStaffViewElementShape<Self> {
        return MusicStaffViewElementShape<Self>(self)
    }
}

@available(macOS 12, *)
struct MusicStaffViewElementShapeView<Element: MusicStaffViewElement>: View {
    var parent: MusicStaffViewElement? = nil
    
    @Environment(\.spaceWidth) var spaceWidth: CGFloat
    @Environment(\.clef) var clef: MusicClef
    @Environment(\.showNaturalAccidentals) var showsNaturalAccidentals
    @Environment(\.debug) var debug: Bool
    @Environment(\.elementColor) var elementColor
    @Environment(\.elementStyle) var elementStyle

    var offset: CGFloat {
        CGFloat(parent?.offset(in: clef) ?? element.offset(in: clef))
    }
    
    var shouldHide: Bool {
        if let accidental = (element as? AnyMusicStaffViewElement)?.unboxed as? MusicAccidental {
            return accidental == .natural && showsNaturalAccidentals == false
        }
        return false
    }
    
    var element: Element
    var body: some View {
        element
            .shape
            .foregroundStyle(elementStyle)
            //.foregroundStyle(elementColor)
            .frame(width: shouldHide ? 0 : nil)
            .aspectRatio(element.aspectRatio, contentMode: .fit)
            .frame(height: element.heightInStaffSpace * spaceWidth)
            .offset(y: element.heightInStaffSpace * spaceWidth * (0.5 - element.anchorPoint.y))
            .rotationEffect(element.direction(in: clef) == .down ? .degrees(180) : .zero)
            .offset(y: -offset * spaceWidth / 2)
    }
}
