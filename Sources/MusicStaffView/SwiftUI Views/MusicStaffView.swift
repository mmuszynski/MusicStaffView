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
struct MusicStaffView: View {
    var debug = false
    var groups: [MusicStaffViewGroup] = []
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
    
    @ViewBuilder private func render(_ group: MusicStaffViewGroup) -> some View {
        EmptyView()
    }
        
    var body: some View {
        GeometryReader { g in
            ForEach(groups) { group in
                render(group)
            }
        }
    }
}

//@available(macOS 12, *)
//@available(iOS 10.0, *)
//struct MusicStaffView_Previews: PreviewProvider {
//    /*
//     static var scale: [AnyMusicStaffViewElement] = try! MusicScale(root: MusicPitch(name: .c, accidental: .natural, octave: 3), mode: .major).map { MusicNote(pitch: $0, rhythm: .quarter).asAnyMusicStaffViewElement }
//     static var test: [AnyMusicStaffViewElement] = [MusicClef.bass.asAnyMusicStaffViewElement] + scale
//     static var previews: some View {
//     MusicStaffView(elements: self.test, maxLedgerLines: 1)
//     .previewLayout(.fixed(width: 800, height: 150))
//     }
//     */
//    
//    static var previews: some View {
//        Group {
//            MusicStaffView(maxLedgerLines: 2) {
//                MusicClef.bass
//                MusicPitch.c
//                    .accidental(.natural)
//                    .octave(4)
//                    .length(.quarter)
//                MusicPitch.c
//                    .accidental(.natural)
//                    .octave(3)
//                    .length(.quarter)
//                MusicNote(pitchName: .c, accidental: .natural, octave: 3, rhythm: .quarter)
//                MusicClef.treble
//                MusicClef.tenor
//            }
//            .previewLayout(.fixed(width: 600, height: 300))
//         
//            MusicStaffView(maxLedgerLines: 2) {
//                MusicClef.treble
//                MusicPitch.a
//                    .octave(4)
//                    .length(.quarter)
//            }
//        }
//    }
//}
