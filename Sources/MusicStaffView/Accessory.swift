//
//  MusicStaffViewAccessory.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/24/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

public enum MusicStaffViewAccessoryPlacement {
    case above, below, leading, trailing, standalone
}

public protocol MusicStaffViewAccessory: MusicStaffViewElement {
    var placement: MusicStaffViewAccessoryPlacement { get }
}
