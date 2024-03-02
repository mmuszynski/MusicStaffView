//
//  SwiftUIView.swift
//
//
//  Created by Mike Muszynski on 4/26/22.
//

import SwiftUI
import Music

@available(iOS 15.0, *)
extension MusicStaffView {
    struct Spacing: OptionSet {
        let rawValue: Int
        
        static let leading = Spacing(rawValue: 1 << 0)
        static let trailing = Spacing(rawValue: 1 << 1)
        
        static let all: Spacing = [.leading, .trailing]
    }
}

@available(macOS 15, *)
@available(iOS 15.0, *)
public struct MusicStaffView: View {
    @Environment(\.debug) var debug
    var elements: [any MusicStaffViewElement]
    var ledgerLines: (above: Int, below: Int)?
    var maxLedgerLines: Int = 2
    var clef: MusicClef = .treble
    
    func spaceWidth(in geometry: GeometryProxy) -> CGFloat {
        var lines: Int
        if let ledger = ledgerLines {
            lines = ledger.above + ledger.below
        } else {
            lines = maxLedgerLines * 2
        }
        return geometry.size.height / (6.0 + CGFloat(lines))
    }
        
    init(clef: MusicClef, @MusicStaffViewElementGroupBuilder _ elements: () -> [any MusicStaffViewElement]) {
        self.clef = clef
        self.elements = elements()
    }
    
    var elementsAsAny: [AnyMusicStaffViewElement] {
        elements.map { AnyMusicStaffViewElement($0) }
    }
    
    @ViewBuilder
    func render(masks: Bool = false) -> some View {
        HStack {
            clef
            ForEach(elementsAsAny) {
                element in
                if masks {
                    MusicStaffViewElementStaffMask(element: element)
                } else {
                    element.body
                }
            }
        }
    }
    
    @ViewBuilder
    func renderElements() -> some View {
        render()
    }
    
    @ViewBuilder
    func renderElementMasks() -> some View {
        render(masks: true)
    }
    
    public var body: some View {
        GeometryReader { g in
            ZStack {
                StaffShapeView(ledgerLines: maxLedgerLines)
                    .mask {
                        ZStack {
                            StaffMask()
                            renderElementMasks()
                        }
                    }
                
                renderElements()
                
                if debug {
                    ZStack {
                        StaffMask()
                        renderElementMasks()
                    }
                    .foregroundStyle(.green.opacity(0.25))
                }
            }
            .spaceWidth(self.spaceWidth(in: g))
            .lineWidth(self.spaceWidth(in: g) / 10)
            .clef(self.clef)
            .position(x: g.size.width / 2, y: g.size.height / 2)
        }
    }
}

@available(macOS 12, *)
@available(iOS 15.0, *)
struct MusicStaffView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MusicStaffView(clef: .treble) {
                MusicPitch.c.octave(4).length(.quarter)
                MusicPitch.d.octave(4).length(.quarter)
                MusicPitch.e.octave(4).length(.quarter)
                MusicPitch.f.accidental(.sharp).octave(4).length(.quarter)
            }
            
            MusicStaffView(clef: .bass) {
                MusicPitch.c.octave(3).length(.quarter)
            }
            .showNaturalAccidentals(false)
        }
        .previewLayout(.fixed(width: 600, height: 400))
        .debug(false)
    }
}
