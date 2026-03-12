//
//  File.swift
//  MusicStaffView
//
//  Created by Mike Muszynski on 3/12/26.
//

import Foundation

protocol MusicStaffViewStyledElement: MusicStaffViewElement {
    associatedtype E: MusicStaffViewElement
    var element: E { get }
    
    func base() -> MusicStaffViewElement
}

extension MusicStaffViewStyledElement {
    func base() -> MusicStaffViewElement {
        var element: Any = self
        while let next = element as? (any MusicStaffViewStyledElement) {
            element = next.element
        }
        return element as! MusicStaffViewElement
    }
}
