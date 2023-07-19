//
//  SwiftUIView.swift
//  
//
//  Created by Mike Muszynski on 6/12/23.
//

import SwiftUI
import Music

struct MusicStaffViewElementView<Element: MusicStaffViewElement>: View {
    var element: Element
    var body: some View {
        element.swiftUIShape
    }
    
    @ViewBuilder func with(spaceWidth width: CGFloat, clef: MusicClef = .bass) -> some View {
        let size = element.size(withSpaceWidth: width)
        let direction = element.direction(in: clef)
        
        
        
        self
            .body
            .position(x: size.width * element.anchorPoint.x, y: size.height * (1 - element.anchorPoint.y))
            .rotationEffect(Angle(degrees: direction == .up ? 0 : 180))
            .offset(y: -CGFloat(element.offset(in: clef)) * width / 2)
            .frame(width: size.width, height: size.height, alignment: .center)
    }
}

struct Spacewidth: ViewModifier {
    var width: CGFloat
    init(_ width: CGFloat) {
        self.width = width
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .with(spaceWidth: width)
        }
    }
}

extension MusicStaffViewElementView {
    func spaceWidth(_ width: CGFloat) -> some View {
        modifier(Spacewidth(width))
    }
}

//extension View {
//    func spaceWidth(_ width: CGFloat) -> some View {
//        modifier(Spacewidth(width))
//    }
//}
