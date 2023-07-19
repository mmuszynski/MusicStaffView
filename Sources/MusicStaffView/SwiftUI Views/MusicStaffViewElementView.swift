//
//  SwiftUIView.swift
//  
//
//  Created by Mike Muszynski on 6/12/23.
//

import SwiftUI
import Music

protocol MusicStaffViewElementView: View {
    associatedtype Element
    var element: Element { get }
    init(element: Element)
}

struct MusicStaffViewSingleElementView<Element: MusicStaffViewElement>: MusicStaffViewElementView {
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

struct MusicStaffViewAccesorizedElementView<Element: MusicStaffViewElement>: MusicStaffViewElementView {
    var element: Element
    var body: some View {
        let accessories  = element.accessoryElements.map(\.asAnyMusicStaffViewAccessory)
        
        HStack {
            //leading elements
            render(accessories, in: .leading)

            VStack {
                render(accessories, in: .above)
                element.body
                render(accessories, in: .below)
            }
            render(accessories, in: .trailing)
        }
        
    }
    
    @ViewBuilder func render(_ accessories: [AnyMusicStaffViewAccessory], in position: MusicStaffViewAccessoryPlacement) -> some View {
        ForEach(accessories.filter { $0.placement == position }) { accessory in
            accessory.body
        }
    }
}

struct MusicStaffViewAccessoryElementView<Element: MusicStaffViewAccessory>: MusicStaffViewElementView {
    var element: Element
    var body: some View {
        element.swiftUIShape
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

struct ElementPreview: PreviewProvider {
    static var previews: some View {
        MusicStaffViewAccesorizedElementView(element: MusicNote(pitchName: .c, accidental: .flat, octave: 3, rhythm: .quarter))
    }
}
