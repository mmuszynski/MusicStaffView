//
//  File.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/11/26.
//

import Foundation
import SwiftUI
import Music

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Example", traits: .fixedLayout(width: 600, height: 400)) {
    Group {
        MusicStaffView {
            MusicClef.treble
            MusicPitch.c.sharp.octave(4).length(.quarter)
            MusicPitch.d.octave(4).length(.quarter)
            MusicPitch.e.octave(4).length(.quarter)
            MusicPitch.f.accidental(.sharp).octave(4).length(.quarter)
        }
    }
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("No Clef", traits: .fixedLayout(width: 600, height: 400)) {
    Group {
        MusicStaffView(clef: .treble) {
            MusicPitch.c.octave(4).length(.quarter)
            MusicPitch.d.octave(4).length(.quarter)
            MusicPitch.e.octave(4).length(.quarter)
            MusicPitch.f.accidental(.sharp).octave(4).length(.quarter)
        }
        .showNaturalAccidentals(true)
    }
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Uniform Trailing Spacing",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicClef.bass
        MusicPitch.c.octave(3).length(.quarter)
    }
    .spacing(.uniformTrailingSpace)
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Explicit Spacing",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicClef.bass
        MusicPitch.c.octave(3).length(.quarter)
    }
    .spacing(.explicit)
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Multiple Clefs",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicClef.bass
        MusicPitch.c.octave(3).quarter
        MusicClef.treble
        MusicPitch.c.octave(6).quarter
    }
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Image Paint",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicClef.bass
        MusicPitch.c.octave(3).quarter
    }
    .background(Color.black)
    .elementStyle(ImagePaint(image: Image(.opaqueChalk)))
    .staffStyle(ImagePaint(image: Image(.opaqueChalk)).secondary)
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("No Ledger Lines",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicClef.bass
        MusicPitch.c.octave(3).quarter
    }
    .background(Color.black)
    .elementStyle(ImagePaint(image: Image(.opaqueChalk)))
    .staffStyle(ImagePaint(image: Image(.opaqueChalk)).secondary)
    .maxLedgerLines(0)
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("Centered",
         traits: .fixedLayout(width: 600, height: 400)) {
    MusicStaffView {
        MusicPitch.c.octave(5).quarter
    }
    .debug()
    .spacing(.uniformLeadingAndTrailingSpace)
    .background(Color.black)
    .elementStyle(ImagePaint(image: Image(.opaqueChalk)))
    .staffStyle(ImagePaint(image: Image(.opaqueChalk)).secondary)
    .maxLedgerLines(0)
}

@available(macOS 14, *)
@available(iOS 17.0, *)
#Preview("github example 2",
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

