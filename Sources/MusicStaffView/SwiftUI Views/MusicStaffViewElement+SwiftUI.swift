//
//  MusicStaffViewElement+SwiftUI.swift
//  
//
//  Created by Mike Muszynski on 4/30/22.
//

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
struct MusicStaffViewElementShape<Element: MusicStaffViewElement>: Shape {
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
    var swiftUIShape: MusicStaffViewElementShape<Self> {
        return MusicStaffViewElementShape<Self>(self)
    }
}

/*
 ====================================================
 Modifier for space widths. Is this the right way to do this?
 ====================================================
 */

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicStaffViewElement {
    @ViewBuilder func with(spaceWidth width: CGFloat, in clef: MusicClef = .bass) -> some View {
        let size = self.size(withSpaceWidth: width)
        let direction = self.direction(in: clef)
        let offset = -CGFloat(self.offset(in: clef)) * width / 2
        
        ForEach(accessoryElements.map(\.asAnyMusicStaffViewAccessory)) { element in
            let elementSize = element.size(withSpaceWidth: width)
            
            switch element.placement {
            default:
                element
                    .body
                    .frame(width: elementSize.width, height: elementSize.height)
                    .offset(y: offset)
            }
        }
        
        self
            .body
            .position(x: size.width * anchorPoint.x, y: size.height * (1 - anchorPoint.y))
            .rotationEffect(Angle(degrees: direction == .up ? 0 : 180))
            .offset(y: offset)
            .frame(width: size.width, height: size.height, alignment: .center)
    }
    
    
    @ViewBuilder func mask(for spaceWidth: CGFloat, in clef: MusicClef = .bass) -> some View {
        let size = self.size(withSpaceWidth: spaceWidth)
        let lineWidth = spaceWidth / 10
        
        //the mask sits on the center line and extends to the anchor point
        //but actually, the anchor point sits on the offset line
        let actualOffset = -CGFloat(self.offset(in: clef)) * spaceWidth / 2
        
        Rectangle()
            //.position(x: size.width * anchorPoint.x, y: size.height * (1 - anchorPoint.y))
            .frame(width: size.width, height: abs(actualOffset) + lineWidth, alignment: .center)
            .offset(y: actualOffset / 2)
    }
}

extension View {
    func with(spaceWidth width: CGFloat, clef: MusicClef = .bass) -> some View {
        return self
            .background(Color.red)
    }
}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicStaffViewAccessory {
    func spaceWidth(parent: MusicStaffViewElement, _ width: CGFloat, clef: MusicClef? = nil) -> some View {
        let size = self.size(withSpaceWidth: width)
        
        return self
            .body
            .position(x: size.width * self.anchorPoint.x, y: size.height * (1 - self.anchorPoint.y))
            .rotationEffect(self.direction(in: clef ?? .bass) == .up ? Angle(degrees: 0) : Angle(degrees: 180))
            .offset(y: -CGFloat(parent.offset(in: clef ?? .bass)) * width / 2)
            .frame(width: size.width, height: size.height, alignment: .center)
    }
}
