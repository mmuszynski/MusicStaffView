//
//  File.swift
//  
//
//  Created by Mike Muszynski on 4/28/22.
//
/*
 This file is filled with empty View protocol declarations along with a single method that allows all of these elements to conform to the protocol.
 
 Currently in Swift, there is no way to extend a protocol such that it will adopt a second protocol, which could then be extended with a default implementation. This is a workaround--the default implementation is provided, and the individual structs declare their conformance without providing any extra implementation.
 */

import SwiftUI
import Music

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicClef: View {}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicNote: View {}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicAccidental: View {}

@available(macOS 12, *)
@available(iOS 13, *)
extension MusicStaffViewElement {
    public var body: some View {
        self.swiftUIShape
    }
}
