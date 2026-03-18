import SwiftUI
import Music

/*
2026-03-11
Tinted clefs cause notes following to draw in the wrong place.
 */
@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Tinted Clef",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicClef.bass
        MusicPitch.c.octave(3).quarter
        MusicClef.treble
            .tint(.blue)
        MusicPitch.c.octave(6).quarter
    }
    .clef(.treble)
    .showNaturalAccidentals(true)
    .lineWidth(10.0)
    .maxLedgerLines(3)
    .staffStyle(.black)
    .elementStyle(.black)
}

/*
 2026-03-13
 Tinted elements do not draw accessory views
 */
@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Tinted note and accessory views",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicClef.bass
        MusicPitch.c.sharp.octave(3).quarter
            .tint(.blue)
    }
}
