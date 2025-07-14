import MusicStaffView
import Music         // pour MusicClef

extension MusicStaffView {

    /// Initialiseur « safe » (aucun ResultBuilder public).
    ///
    /// Exemple :
    /// ```swift
    /// MusicStaffView(clef: .treble)
    ///     .spacing(.uniformLeadingAndTrailingSpace)
    ///     .maxLedgerLines(3)
    /// ```
    ///
    /// - Parameters:
    ///   - clef:     Clef d’affichage (défaut : .treble).
    ///   - elements: Éléments (notes, silences…) facultatifs.
    public init(
        clef: MusicClef = .treble,
        elements: [any MusicStaffViewElement] = []
    ) {
        // On délègue au constructeur “builder” interne, mais l’appelant ne
        // voit plus ce builder : conflit ViewBuilder résolu.
        self.init { [clef] + elements }
    }
}
