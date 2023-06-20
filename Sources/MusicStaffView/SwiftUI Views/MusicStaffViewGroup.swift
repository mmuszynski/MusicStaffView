//
//  SwiftUIView.swift
//
//
//  Created by Mike Muszynski on 6/16/23.
//

import SwiftUI
import Music

@available(iOS 15.0, *)
struct MusicStaffViewGroup: View {
    var clef: MusicClef = .bass
    var elements: [any MusicStaffViewElement] = []
    var ledgerLines: (above: Int, below: Int)?
    var maxLedgerLines: Int = 0
    
    
    /// Caluclates the space width in a given geometry
    /// - Parameter geometry: The geometry proxy
    /// - Returns: A height suitable for drawing the various MusicStaffViewElement items contained in the array
    func spaceWidth(in geometry: GeometryProxy) -> CGFloat {
        var lines: Int
        if let ledger = ledgerLines {
            lines = ledger.above + ledger.below
        } else {
            lines = maxLedgerLines * 2
        }
        return geometry.size.height / (6.0 + CGFloat(lines))
    }
    
    init(maxLedgerLines: Int = 2, @MusicStaffViewBuilder _ elements: () -> [any MusicStaffViewElement]) {
        self.maxLedgerLines = maxLedgerLines
        self.elements = elements().map { AnyMusicStaffViewElement($0) }
    }
    
    var body: some View {
        GeometryReader { g in
            let spaceWidth = spaceWidth(in: g)
            
            ZStack {
                StaffShape(spaceWidth: spaceWidth,
                           ledgerLines: maxLedgerLines)
                    .stroke()
                    .mask {
                        ZStack {
                            StaffShape.staffMask(withSpaceWidth: spaceWidth)
                            
                            HStack {
                                renderMask(elements, in: g)
                            }
                        }
                    }
                
                HStack {
                    render(elements, in: g)
                }
                
                
            }
        }
    }
    
    @ViewBuilder private func render(_ elements: [any MusicStaffViewElement], in geometry: GeometryProxy) -> some View {
        let spaceWidth = spaceWidth(in: geometry)
        
        ForEach(elements.map(\.asAnyMusicStaffViewElement)) { element in

            element
                .with(spaceWidth: spaceWidth, in: clef)
        }
    }
    
    @ViewBuilder private func renderMask(_ elements: [any MusicStaffViewElement], in geometry: GeometryProxy) -> some View {
        let spaceWidth = spaceWidth(in: geometry)
        
        ForEach(elements.map(\.asAnyMusicStaffViewElement)) { element in

            element
                .mask(for: spaceWidth, in: clef)
        }
    }
    
    func clef(_ clef: MusicClef) -> MusicStaffViewGroup {
        var new = self
        new.clef = clef
        return new
    }
}

@available(iOS 15.0, *)
struct MusicStaffViewGroupPreviews: PreviewProvider {
    static var previews: some View {
        MusicStaffViewGroup {
            MusicClef.treble
            MusicPitch.c
                .accidental(.natural)
                .octave(4)
                .length(.quarter)
            MusicPitch.c
                .accidental(.natural)
                .octave(5)
                .length(.quarter)
            MusicNote(pitchName: .e, accidental: .natural, octave: 4, rhythm: .quarter)
        }
        .clef(.treble)
        .previewLayout(.fixed(width: 600, height: 300))
    }
}
