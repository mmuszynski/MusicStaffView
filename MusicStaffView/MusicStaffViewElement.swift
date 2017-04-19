//
//  MusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit
import Music

public enum MusicStaffViewElementType {
    case clef(MusicClef)
    case note(MusicPitch, MusicRhythm)
    case accidental(MusicPitchAccidental)
    case none
}

enum NoteFlagDirection {
    case up
    case down
}

public protocol MusicStaffViewElement {
    var type: MusicStaffViewElementType { get }
}
