//
//  MusicClef+Drawable.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/17/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music

extension MusicClef: MusicStaffViewDrawable {
    func layer(atHorizontalPosition: CGFloat) -> MusicStaffViewElementLayer {
        fatalError()
    }
}
