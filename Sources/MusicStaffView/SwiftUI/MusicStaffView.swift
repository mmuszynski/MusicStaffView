//
//  SwiftUIView.swift
//
//
//  Created by Mike Muszynski on 4/26/22.
//

import SwiftUI
import Music

@available(macOS 14, *)
@available(iOS 15.0, *)
public struct MusicStaffView: View {
    ///Instructs the `MusicStaffView` to draw notes using the spacing set in `preferredHorizontalSpacing` or to fill all available space by dividing the space for notes into equal parts.
    ///
    /// **Values**
    /// - *preferred*: Elements are drawn according to the `preferredHorizontalSpacing` attribute
    /// - *uniformFullWidth*: Elements are drawn an equal width from each other, with no spacing at either margin
    /// - *uniformTrailingSpace*: Elements are drawn an equal width from each other, with another equal space at the trailing edge
    /// - *uniformLeadingAndTrailingSpace*: Elements are drawn an equal width from each other, with equal spacing at the leading and trailing edges
    ///
    ///For certain uses, notes on a staff should be drawn to maximize all available space. In other cases (for example, when the notes will take up more space than the visible area of the view itself), it makes sense to draw the notes as close together as possible. These scenarios are represented in `MusicStaffViewSpacingType` as `preferred`, which uses the `preferredHorizontalSpacing` property, or `uniform`, which discards the property in favor of spacing notes equally across the view.
    ///
    ///- Warning: There may be cases where using uniform spacing will still cause notes to be drawn outside the visible area of the `MusicStaffView`. Currently, the framework takes no position in these situations.
    public enum Spacing {
        //FIXME: What happens when spacing causes notes to draw past the bounds of the view?
        case preferred
        case uniformFullWidth
        case uniformTrailingSpace
        case uniformLeadingAndTrailingSpace
        case explicit
        
        var isUniform: Bool {
            self != .preferred && self != .explicit
        }
        
        var isTrailing: Bool {
            self == .uniformTrailingSpace || self == .uniformLeadingAndTrailingSpace
        }
        
        var isLeading: Bool {
            self == .uniformLeadingAndTrailingSpace
        }
    }
    
    @Environment(\.debug) var debug
    @Environment(\.showNaturalAccidentals) var showsNaturalAccidentals
    @Environment(\.staffViewElementSpacing) var spacing
    
    var elements: [any MusicStaffViewElement]
    var ledgerLines: (above: Int, below: Int)?
    @Environment(\.maxLedgerLines) var maxLedgerLines
    
    @available(*, unavailable)
    var clef: MusicClef { fatalError() }
    
    private var startingClef: MusicClef = .treble
    
    func spaceWidth(in geometry: GeometryProxy) -> CGFloat {
        var lines: Int
        if let ledger = ledgerLines {
            lines = ledger.above + ledger.below
        } else {
            lines = maxLedgerLines * 2
        }
        return geometry.size.height / (6.0 + CGFloat(lines))
    }
    
    
    /// The basic initializer for `MusicStaffView`. Specifies an optional starting clef.
    ///
    /// `MusicStaffView` can be initialized using a result builder that allows for an improved declarative syntax when using the framework. See `MusicStaffViewElementGroupBuilder` for a description of how elements are declared.
    ///
    /// The view requires the selection of a clef, and will use a default value of treble clef if not otherwise specified. However, if a clef is declared as the first element of the result builder, this will override any selection provided to the initializer. Note that this initial clef is not drawn unless it is declared in the element array, but it is required as a reference point for the drawing of elements.
    ///
    /// - Parameters:
    ///   - clef: An initial `MusicClef` that the view will use to position its elements.
    ///   - elements: A `MusicStaffViewElementGroupBuilder` block that contains the elements to draw.
    public init(clef: MusicClef = .treble, @MusicStaffViewElementGroupBuilder _ elements: () -> [any MusicStaffViewElement]) {
        self.startingClef = clef
        self.elements = elements()
    }
    
    var elementsAsAny: [AnyMusicStaffViewElement] {
        elements.map { AnyMusicStaffViewElement($0) }
    }
    
    /// Reduces the element array into groups starting with each clef
    ///
    /// In order to change the offset location for items drawn in the staff space when clefs change, elements are formed into groups with the clef as the initial element of the group. For example, if the bass clef begins the group, elements will be drawn as they should in bass clef. If for some reason, a clef change is indicated, offsets need to be recalculated.
    ///
    /// As of 2026-03-12, the framework was updated to include individually styled elements. As this required a wrapper, it was no longer possible to use the type of the element, and instead, a bit more convoluted introspection to the class was necessary (see the note below).
    var groupedByClef: [[AnyMusicStaffViewElement]] {
        //Placeholder group that is added once the group is finalized
        var currentGroup: [MusicStaffViewElement] = []
        
        //The return value
        var allGroups: [[MusicStaffViewElement]] = []
        
        //Iterate over all elements in the array as AnyMusicStaffViewElement
        for element in elements {
            /*This is the convoluted part. If the element is stylized individually, its type will be a wrapper that contains a base element. The base element should be evaluated, but non-styled elements can be evaluated without unwrapping.
             
             MusicStaffViewStyledElement has a recursive unwrapping function (in case of elements that are wrapped in multiple ways, which is currently not necessary but may be?) and this is indicated with the initial code
             
             (element as? (any MusicStaffViewStyledElement))?.base()
             
             If this returns nil, the coalescing operator will return the element, indicating that the element was not wrapped.
             */
            let base = (element as? (any MusicStaffViewStyledElement))?.base() ?? element
            
            //If the element is a clef, start a new group. If it's not, append it to the current group.
            if base is MusicClef {
                if !currentGroup.isEmpty {
                    allGroups.append(currentGroup)
                }
                currentGroup = [element]
            } else {
                currentGroup.append(element)
            }
        }
        
        //Add the last group to the groups array
        if !currentGroup.isEmpty {
            allGroups.append(currentGroup)
        }
        
        //Finally, return the groups, type-erased
        return allGroups.map { $0.map { AnyMusicStaffViewElement($0) }}
    }
    
    /*
     2024-03-03: There is probably a better way to do this by arranging into groups. But it seems to work right now.
     */
    @ViewBuilder
    func render(masks: Bool = false) -> some View {
        HStack {
            if spacing.isLeading {
                Spacer()
            }
            
            ForEach(groupedByClef.indices, id: \.self) { groupIndex in
                let groupElements = groupedByClef[groupIndex]
                let clef = groupElements.first?.unboxed as? MusicClef ?? self.startingClef
                
                ForEach(groupElements) { element in
                    if masks {
                        MusicStaffViewElementStaffMask(element: element)
                            .clef(clef)
                    } else {
                        element.body
                            .clef(clef)
                    }
                    
                    if spacing.isUniform {
                        Spacer()
                    }
                }
                
            }
        }
    }
    
    @ViewBuilder
    func renderElements() -> some View {
        render()
    }
    
    @ViewBuilder
    func renderElementMasks() -> some View {
        render(masks: true)
    }
    
    public var body: some View {
        GeometryReader { g in
            ZStack {
                StaffShapeView()
                    .mask {
                        ZStack {
                            StaffMask()
                            renderElementMasks()
                        }
                    }
                
                renderElements()
                
                if debug {
                    ZStack {
                        StaffMask()
                        renderElementMasks()
                    }
                    .foregroundStyle(.green.opacity(0.25))
                }
            }
            .spaceWidth(self.spaceWidth(in: g))
            .lineWidth(self.spaceWidth(in: g) / 10)
            .position(x: g.size.width / 2, y: g.size.height / 2)
        }
    }
}
