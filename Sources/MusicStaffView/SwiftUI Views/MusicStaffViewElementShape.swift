//
//  File.swift
//  
//
//  Created by Mike Muszynski on 7/19/23.
//

import Foundation
import SwiftUI
import Music

/*
 ====================================================
 Generic Element Paths
 ====================================================
 
 The following code allows MusicStaffViewElement objects to be rendered by SwiftUI by creating a Shape to take advantage of the path that each object is required to provide as part of the MusicStaffViewElement protocol
 */

@available(macOS 12, *)
@available(iOS 13, *)
/// Translates the `path` function of the `MusicStaffViewElement` into a specific, but generic `Shape` for use in SwiftUI
///
/// 2022-05-01: I was creating a new shape for every element, and decided instead to try to implement it with a generic `Shape` that could take any type of `MusicStaffViewElement`
struct MusicStaffViewElementShape<Element: MusicStaffViewElement>: Shape {
    var element: Element
    init(_ element: Element) { self.element = element }
    func path(in rect: CGRect) -> Path {
        Path(element.path(in: rect))
    }
}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicStaffViewElement {
    
    /// Returns the generic `Shape` struct to be drawn in SwiftUI
    ///
    /// For more information, see `MusicStaffViewElementShape<Element>` above.
    ///
    /// 2022-05-01: The second of the necessary elements to draw these shapes in SwiftUI, this method extends `MusicStaffViewElement` to take advantage of the generic `Shape` defined in `MusicStaffViewElementShape`
    var shape: MusicStaffViewElementShape<Self> {
        return MusicStaffViewElementShape<Self>(self)
    }
}
