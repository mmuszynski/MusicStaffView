//
//  File.swift
//  
//
//  Created by Mike Muszynski on 3/3/24.
//

import SwiftUI

/*
 - MARK: Environment Key: Element Color
 ==========================================================================================
 An environment key used to change the color of the elements in a MusicStaffView
 ==========================================================================================
 */

struct ElementColorKey: EnvironmentKey {
    static var defaultValue: Color = .black
}

extension EnvironmentValues {
    var elementColor: Color {
        get { self[ElementColorKey.self] }
        set { self[ElementColorKey.self] = newValue }
    }
}

struct ElementColorModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .environment(\.elementColor, color)
    }
}

extension View {
    public func elementColor(_ color: Color) -> some View {
        modifier(ElementColorModifier(color: color))
    }
}

/*
 - MARK: Environment Key: Element Style
 ==========================================================================================
 An environment key used to change the ShapeStyle of the elements in a MusicStaffView
 ==========================================================================================
 */

struct ElementStyleKey: EnvironmentKey {
    static var defaultValue: AnyShapeStyle = AnyShapeStyle(.primary)
}

extension EnvironmentValues {
    var elementStyle: AnyShapeStyle {
        get { self[ElementStyleKey.self] }
        set { self[ElementStyleKey.self] = newValue }
    }
}

struct ElementStyleModifier: ViewModifier {
    var style: AnyShapeStyle
    func body(content: Content) -> some View {
        content
            .environment(\.elementStyle, style)
    }
}

extension View {
    public func elementStyle<S: ShapeStyle>(_ style: S) -> some View {
        modifier(ElementStyleModifier(style: AnyShapeStyle(style)))
    }
}

/*
 - MARK: Environment Key: Staff Color
 ==========================================================================================
 An environment key used to change the color of the staff in a MusicStaffView
 ==========================================================================================
 */

struct StaffColorKey: EnvironmentKey {
    static var defaultValue: Color = .black
}

extension EnvironmentValues {
    var staffColor: Color {
        get { self[StaffColorKey.self] }
        set { self[StaffColorKey.self] = newValue }
    }
}

struct StaffColorModifier: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .environment(\.staffColor, color)
    }
}

extension View {
    public func staffColor(_ color: Color) -> some View {
        modifier(StaffColorModifier(color: color))
    }
}

/*
 - MARK: Environment Key: Staff Style
 ==========================================================================================
 An environment key used to change the ShapeStyle of the staffs in a MusicStaffView
 ==========================================================================================
 */

struct StaffStyleKey: EnvironmentKey {
    static var defaultValue: AnyShapeStyle = AnyShapeStyle(.primary)
}

extension EnvironmentValues {
    var staffStyle: AnyShapeStyle {
        get { self[StaffStyleKey.self] }
        set { self[StaffStyleKey.self] = newValue }
    }
}

struct StaffStyleModifier: ViewModifier {
    var style: AnyShapeStyle
    func body(content: Content) -> some View {
        content
            .environment(\.staffStyle, style)
    }
}

extension View {
    public func staffStyle<S>(_ style: S) -> some View where S: ShapeStyle {
        modifier(StaffStyleModifier(style: AnyShapeStyle(style)))
    }
}
