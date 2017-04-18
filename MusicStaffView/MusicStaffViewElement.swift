//
//  MusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 1/4/15.
//  Copyright (c) 2015 Mike Muszynski. All rights reserved.
//

import UIKit

public enum MusicStaffViewElementType {
    case clef(MusicClefType)
    case note(MusicPitchName, MusicPitchAccidental, MusicNoteLength)
    case accidental(MusicPitchAccidental)
    case none
}

enum NoteFlagDirection {
    case up
    case down
}

public class MusicStaffViewElement: NSObject {
   
}
