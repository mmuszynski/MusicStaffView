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
