//
//  SwiftUIView.swift
//
//
//  Created by Mike Muszynski on 6/16/23.
//

import SwiftUI
import Music

@available(iOS 15.0, *)
struct MusicStaffViewGroup: Identifiable, View {
    let id: UUID = UUID()
    
    var elements: [any MusicStaffViewElement] = []
    
    var clef: MusicClef = .bass
    var hidesClef: Bool = false
    
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
    
    init(clef: MusicClef = .treble, maxLedgerLines: Int = 2, @MusicStaffViewGroupBuilder _ elements: () -> [any MusicStaffViewElement]) {
        self.clef = clef
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
                            .padding(.horizontal)
                            
                        }
                    }
                
                HStack {
                    render(elements, in: g)
                }
                .padding(.horizontal)
            }
            
        }
    }
    
    @ViewBuilder private func renderClef(with spaceWidth: CGFloat, in clef: MusicClef) -> some View {
        if !self.hidesClef {
            Spacer()
            clef
                .with(spaceWidth: spaceWidth, in: clef)
        }
    }
    
    @ViewBuilder private func render(_ elements: [any MusicStaffViewElement], in geometry: GeometryProxy) -> some View {
        let spaceWidth = spaceWidth(in: geometry)
        
        renderClef(with: spaceWidth, in: clef)
        
        ForEach(elements.map(\.asAnyMusicStaffViewElement)) { element in
            Spacer()
            element
                .with(spaceWidth: spaceWidth, in: clef)
        }
        Spacer()
    }
    
    @ViewBuilder private func renderMask(_ elements: [any MusicStaffViewElement], in geometry: GeometryProxy) -> some View {
        let spaceWidth = spaceWidth(in: geometry)
        
        renderClef(with: spaceWidth, in: clef)

        ForEach(elements.map(\.asAnyMusicStaffViewElement)) { element in
            Spacer()
            element
                .mask(for: spaceWidth, in: clef)
        }
        
        Spacer()
    }
    
    func clef(_ clef: MusicClef) -> Self {
        var new = self
        new.clef = clef
        return new
    }
    
    func hideClef() -> Self {
        var new = self
        new.hidesClef = true
        return new
    }
}

@available(iOS 15.0, *)
struct MusicStaffViewGroupPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            MusicStaffViewGroup(clef: .treble) {
                MusicPitch.c
                    .accidental(.flat)
                    .octave(4)
                    .length(.quarter)
                MusicPitch.c
                    .accidental(.natural)
                    .octave(5)
                    .length(.quarter)
                MusicNote(pitchName: .e, accidental: .natural, octave: 4, rhythm: .quarter)
            }
        }
        .previewLayout(.fixed(width: 600, height: 300))

    }
}
