//
//  SwiftUIView.swift
//  
//
//  Created by Mike Muszynski on 4/26/22.
//

import SwiftUI
import Music

extension AnyMusicStaffViewElement: Identifiable {
    var id: UUID {
        return self.uuid
    }
    
    public static func == (lhs: AnyMusicStaffViewElement, rhs: AnyMusicStaffViewElement) -> Bool {
        if type(of: lhs) != type(of: rhs) {
            return false
        }
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.path(in: .zero))
    }
}

@available(macOS 12, *)
@available(iOS 10.0, *)
struct MusicStaffSwiftUIView: View {
    var elements: [AnyMusicStaffViewElement] = []
    var ledgerLines: (above: Int, below: Int)?
    var maxLedgerLines: Int = 0
    func spaceWidth(in geometry: GeometryProxy) -> CGFloat {
        var lines: Int
        if let ledger = ledgerLines {
            lines = ledger.above + ledger.below
        } else {
            lines = maxLedgerLines * 2
        }
        return geometry.size.height / (6.0 + CGFloat(lines))
    }
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                StaffShape(spaceWidth: self.spaceWidth(in: g), ledgerLines: maxLedgerLines)
                    .stroke()
                    .mask{
                        StaffShape.staffMask(withSpaceWidth: spaceWidth(in: g))
                    }
                    .overlay {
                        HStack {
                            Group {
                                ForEach(elements) { element in
                                    element
                                        .spaceWidth(self.spaceWidth(in: g))
                                }
                                Spacer()
                            }
                        }
                    }
            }
        }
    }
}

@available(macOS 12, *)
@available(iOS 10.0, *)
struct MusicStaffSwiftUIView_Previews: PreviewProvider {
    static var scale: [AnyMusicStaffViewElement] = try! MusicScale(root: MusicPitch(name: .c, accidental: .natural, octave: 3), mode: .major).map { MusicNote(pitch: $0, rhythm: .quarter).asAnyMusicStaffViewElement }
    static var test: [AnyMusicStaffViewElement] = [MusicClef.bass.asAnyMusicStaffViewElement] + scale
    static var previews: some View {
        MusicStaffSwiftUIView(elements: self.test, maxLedgerLines: 1)
            .previewLayout(.fixed(width: 800, height: 100))
    }
}
