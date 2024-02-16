//
//  SwiftUIView.swift
//  
//
//  Created by Mike Muszynski on 2/16/24.
//

import SwiftUI
import Music

struct UIMusicStaffViewExampleView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIMusicStaffView {
        let staffView = UIMusicStaffView(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
        staffView.maxLedgerLines = 3
        staffView.spacing = .preferred
        staffView.elementArray = [MusicClef.treble, MusicPitch.c.octave(4).note(with: .quarter)]
        return staffView
    }
    
    func updateUIView(_ uiView: UIMusicStaffView, context: Context) {
        uiView.elementArray = []
    }
    
    typealias UIViewType = UIMusicStaffView
    
}

#Preview {
    UIMusicStaffViewExampleView()
        .padding()
}