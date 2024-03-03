//
//  File.swift
//
//
//  Created by Mike Muszynski on 4/28/22.
//

import SwiftUI
import Music

@available(macOS 12, *)
@available(iOS 13, *)
struct StaffShape: Shape {
    var spaceWidth: CGFloat = 10
    var lineWidth: CGFloat = 1
    var ledgerLines: Int
    func path(in rect: CGRect) -> Path {
        Path(UIMusicStaffView.staffPath(in: rect, spaceWidth: self.spaceWidth, ledgerLines: self.ledgerLines))
    }
}

struct StaffShapeView: View {
    @Environment(\.spaceWidth) var spaceWidth: CGFloat
    @Environment(\.lineWidth) var lineWidth: CGFloat
    var ledgerLines: Int
    
    var body: some View {
        VStack(spacing: spaceWidth - lineWidth) {
            ForEach(0..<(5+ledgerLines*2), id: \.self) { _ in
                Rectangle()
                    .frame(height: lineWidth)
            }
        }
    }
}

struct StaffMask: View {
    @Environment(\.spaceWidth) var spaceWidth: CGFloat
    @Environment(\.lineWidth) var lineWidth: CGFloat
    
    var body: some View {
        Rectangle()
            .frame(height: spaceWidth * 4 + lineWidth)
    }
}

struct MusicStaffViewElementStaffMask: View {
    @Environment(\.spaceWidth) var spaceWidth: CGFloat
    @Environment(\.clef) var clef: MusicClef
    @Environment(\.lineWidth) var lineWidth: CGFloat
    @Environment(\.showNaturalAccidentals) var showsNaturalAccidentals

    var element: MusicStaffViewElement
    var parent: MusicStaffViewElement? = nil
    
    var body: some View {
        //the mask sits on the center line and extends to the anchor point
        //but actually, the anchor point sits on the offset line
        let actualOffset = -CGFloat(element.offset(in: clef)) * spaceWidth / 2
        let size = element.size(withSpaceWidth: spaceWidth)
        let leadingAccessories = element.leadingAccessories.filter { acc in
            !((acc.unboxed as? MusicAccidental == .natural) && !showsNaturalAccidentals)
        }

        HStack(spacing: 0) {
            ForEach(leadingAccessories) { accessory in
                MusicStaffViewElementStaffMask(element: accessory, parent: element)
            }
            Rectangle()
            //.position(x: size.width * anchorPoint.x, y: size.height * (1 - anchorPoint.y))
                .frame(width: size.width, height: abs(actualOffset) + lineWidth, alignment: .center)
                .offset(y: actualOffset / 2)
        }
    }
}

struct StaffShapePreview: PreviewProvider {
    static var previews: some View {
        StaffShapeView(ledgerLines: 2)
            .spaceWidth(30)
            .lineWidth(5)
            .previewLayout(.fixed(width: 600, height: 300))
    }
}
