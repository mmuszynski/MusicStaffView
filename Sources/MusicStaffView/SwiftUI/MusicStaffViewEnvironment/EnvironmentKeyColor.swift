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

//struct ElementColorKey: EnvironmentKey {
//    static var defaultValue: Color = .black
//}
//
//extension EnvironmentValues {
//    var elementColor: Color {
//        get { self[ElementColorKey.self] }
//        set { self[ElementColorKey.self] = newValue }
//    }
//}
//
//struct ElementColorModifier: ViewModifier {
//    var color: Color
//    func body(content: Content) -> some View {
//        content
//            .environment(\.elementColor, color)
//    }
//}
//
//extension View {
//    public func elementColor(_ color: Color) -> some View {
//        modifier(ElementColorModifier(color: color))
//    }
//}

extension EnvironmentValues {
    @Entry var elementColor: Color = .black
}

/*
 - MARK: Environment Key: Element Style
 ==========================================================================================
 An environment key used to change the ShapeStyle of the elements in a MusicStaffView
 ==========================================================================================
 */

//@available(iOS 15.0, *)
//@available(macOS 12.0, *)
//struct ElementStyleKey: EnvironmentKey {
//    static var defaultValue: AnyShapeStyle = AnyShapeStyle(.primary)
//}
//
//@available(iOS 15.0, *)
//@available(macOS 12.0, *)
//extension EnvironmentValues {
//    var elementStyle: AnyShapeStyle {
//        get { self[ElementStyleKey.self] }
//        set { self[ElementStyleKey.self] = newValue }
//    }
//}
//
//@available(iOS 15.0, *)
//@available(macOS 12.0, *)
//struct ElementStyleModifier: ViewModifier {
//    var style: AnyShapeStyle
//    func body(content: Content) -> some View {
//        content
//            .environment(\.elementStyle, style)
//    }
//}
//
//@available(iOS 15.0, *)
//@available(macOS 12.0, *)
//extension View {
//    public func elementStyle<S: ShapeStyle>(_ style: S) -> some View {
//        modifier(ElementStyleModifier(style: AnyShapeStyle(style)))
//    }
//}

@available(iOS 15, *)
@available(macOS 12.0, *)
extension EnvironmentValues {
    @Entry var elementStyle: AnyShapeStyle = AnyShapeStyle(.primary)
}

@available(iOS 15, *)
@available(macOS 12.0, *)
extension View {
    public func elementStyle<S>(_ style: S) -> some View where S: ShapeStyle {
        environment(\.elementStyle, AnyShapeStyle(style))
    }
}

/*
 - MARK: Environment Key: Staff Color
 ==========================================================================================
 An environment key used to change the color of the staff in a MusicStaffView
 ==========================================================================================
 */

//struct StaffColorKey: EnvironmentKey {
//    static var defaultValue: Color = .black
//}
//
//extension EnvironmentValues {
//    var staffColor: Color {
//        get { self[StaffColorKey.self] }
//        set { self[StaffColorKey.self] = newValue }
//    }
//}
//
//struct StaffColorModifier: ViewModifier {
//    var color: Color
//    func body(content: Content) -> some View {
//        content
//            .environment(\.staffColor, color)
//    }
//}
//
//extension View {
//    public func staffColor(_ color: Color) -> some View {
//        modifier(StaffColorModifier(color: color))
//    }
//}

extension EnvironmentValues {
    @Entry var staffColor: Color = .black
}

/*
 - MARK: Environment Key: Staff Style
 ==========================================================================================
 An environment key used to change the ShapeStyle of the staffs in a MusicStaffView
 ==========================================================================================
 */

@available(iOS 15, *)
@available(macOS 12.0, *)
extension EnvironmentValues {
    @Entry var staffStyle: AnyShapeStyle = AnyShapeStyle(.secondary)
}

//@available(iOS 15, *)
//@available(macOS 12.0, *)
//extension EnvironmentValues {
//    var staffStyle: AnyShapeStyle {
//        get { self[StaffStyleKey.self] }
//        set { self[StaffStyleKey.self] = newValue }
//    }
//}
//
//@available(iOS 15, *)
//@available(macOS 12.0, *)
//struct StaffStyleModifier: ViewModifier {
//    var style: AnyShapeStyle
//    func body(content: Content) -> some View {
//        content
//            .environment(\.staffStyle, style)
//    }
//}

@available(iOS 15, *)
@available(macOS 12.0, *)
extension View {
    public func staffStyle<S>(_ style: S) -> some View where S: ShapeStyle {
        environment(\.staffStyle, AnyShapeStyle(style))
    }
}
