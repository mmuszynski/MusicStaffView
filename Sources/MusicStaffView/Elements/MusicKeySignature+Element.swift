//
//  MusicKeySignature+Element.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 8/14/17.
//  Copyright © 2017 Mike Muszynski. All rights reserved.
//

#if os(macOS)
import Cocoa
#elseif os(iOS)
import UIKit
#endif

import Foundation
import Music
import SwiftUI

extension MusicKeySignature: MusicStaffViewElement {
    public func path(in frame: CGRect) -> CGPath {
        CGPath(rect: .zero, transform: nil)
    }
    
    public var aspectRatio: CGFloat {
        return 1
    }
    
    public var heightInStaffSpace: CGFloat {
        return 0
    }
}
