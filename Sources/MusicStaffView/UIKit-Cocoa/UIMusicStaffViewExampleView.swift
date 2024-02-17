//
//  SwiftUIView.swift
//  
//
//  Created by Mike Muszynski on 2/16/24.
//

import SwiftUI
import Music

struct UIMusicStaffViewExampleView: UIViewRepresentable {
    let staffView: UIMusicStaffView
    init(@MusicStaffViewElementGroupBuilder _ elements: () -> [any MusicStaffViewElement]) {
        staffView = UIMusicStaffView(frame: .zero, elements)
    }
    
    func makeUIView(context: Context) -> UIMusicStaffView {
        staffView.maxLedgerLines = 3
        staffView.spacing = .preferred
        return staffView
    }
    
    func updateUIView(_ uiView: UIMusicStaffView, context: Context) {

    }
}

#Preview {
    UIMusicStaffViewExampleView {
        MusicClef.treble
        MusicPitch.c.sharp.quarter
    }
    .padding()
}
