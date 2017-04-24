//
//  MusicStaffViewAccessoryElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/24/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation

enum MusicStaffViewAccessoryPlacement {
    case above, below, leading, trailing
}

protocol MusicStaffViewAccessoryElement: MusicStaffViewElement {
    var placement: MusicStaffViewAccessoryPlacement { get }
    var offsetFromParent: CGFloat { get }
}
