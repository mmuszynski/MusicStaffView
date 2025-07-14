//
//  MusicStaffView+SafeInit.swift
//
//  Ajoute un initialiseur sans builder pour éliminer le conflit
//  “buildExpression is unavailable” dans les ViewBuilder SwiftUI.
//

import Music                 // ← nécessaire pour MusicClef
@available(iOS 15.0, *)
public extension MusicStaffView {

    /// Initialiseur sans `resultBuilder`.
    ///
    /// Exemple :
    /// ```swift
    /// MusicStaffView(clef: .treble)
    ///     .spacing(.uniformLeadingAndTrailingSpace)
    ///     .maxLedgerLines(3)
    /// ```
    init(
        clef: MusicClef = .treble,
        elements: [any MusicStaffViewElement] = []
    ) {
        // Délégation à l’init “builder”, mais encapsulé ici :
        self.init { [clef] + elements }
    }
}
