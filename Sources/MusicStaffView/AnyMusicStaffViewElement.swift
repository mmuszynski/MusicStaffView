//
//  AnyMusicStaffViewElement.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 4/24/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

import Foundation
import Music
import QuartzCore

struct AnyMusicStaffViewElement: MusicStaffViewElement {
    var uuid: UUID = .init()
    
    private var wrapped: MusicStaffViewElement
    
    init(_ wrapped: MusicStaffViewElement) {
        self.wrapped = wrapped
    }
    
    func path(in frame: CGRect) -> CGPath {
        return wrapped.path(in: frame)
    }
    
    var aspectRatio: CGFloat {
        return wrapped.aspectRatio
    }
    
    var heightInStaffSpace: CGFloat {
        return wrapped.heightInStaffSpace
    }
    
    var unboxed: MusicStaffViewElement {
        return self.wrapped
    }
    
    var anchorPoint: CGPoint {
        return wrapped.anchorPoint
    }
    
    func offset(in clef: MusicClef) -> Int {
        return wrapped.offset(in: clef)
    }
    
    func direction(in clef: MusicClef) -> MusicStaffViewElementDirection {
        return wrapped.direction(in: clef)
    }
}

extension MusicStaffViewElement {
    var asAnyMusicStaffViewElement: AnyMusicStaffViewElement {
        AnyMusicStaffViewElement(self)
    }
}
