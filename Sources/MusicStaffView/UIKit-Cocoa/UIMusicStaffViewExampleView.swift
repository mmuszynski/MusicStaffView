//
//  SwiftUIView.swift
//  
//
//  Created by Mike Muszynski on 2/16/24.
//

import SwiftUI
import Music

#if os(iOS)
struct UIMusicStaffViewExampleView: UIViewRepresentable {
    let staffView: UIMusicStaffView
    init(@MusicStaffViewElementGroupBuilder _ elements: () -> [any MusicStaffViewElement]) {
        staffView = UIMusicStaffView(frame: .zero, elements)
        staffView.shouldDrawNaturals = false
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
        MusicPitch.c.quarter
    }
    .padding()
}
#elseif os(macOS)

struct NSMusicStaffViewExampleView: NSViewRepresentable {
    let staffView: UIMusicStaffView
    init(@MusicStaffViewElementGroupBuilder _ elements: () -> [any MusicStaffViewElement]) {
        staffView = UIMusicStaffView(frame: .zero, elements)
        staffView.shouldDrawNaturals = false
    }
    
    func makeNSView(context: Context) -> UIMusicStaffView {
        staffView.maxLedgerLines = 3
        staffView.spacing = .preferred
        return staffView
    }
    
    func updateNSView(_ uiView: UIMusicStaffView, context: Context) {
        
    }
}

#Preview {
    NSMusicStaffViewExampleView {
        MusicClef.treble
        MusicPitch.c.quarter
    }
    .padding()
}
#endif
