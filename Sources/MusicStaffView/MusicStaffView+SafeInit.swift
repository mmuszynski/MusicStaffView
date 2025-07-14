import MusicStaffView
import Music   // pour MusicClef

@available(iOS 15.0, *)
public extension MusicStaffView {

    /// Initialiseur sans *result-builder* (utilisable dans un `ViewBuilder` SwiftUI).
    ///
    /// - Parameters:
    ///   - clef:     Clef affichée (défaut : `.treble`).
    ///   - elements: Éléments supplémentaires (notes, silences…) optionnels.
    init(
        clef: MusicClef = .treble,
        elements: [any MusicStaffViewElement] = []
    ) {
        self.init { [clef] + elements }    // délègue à l’init “builder”
    }
}
