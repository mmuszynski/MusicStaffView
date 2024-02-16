import XCTest
@testable import MusicStaffView
import Music

final class MusicStaffViewTests: XCTestCase {
    func testAnyMusicStaffViewElement() throws {
        let _: [AnyMusicStaffViewElement] = [MusicClef.bass].map { AnyMusicStaffViewElement($0) }
        let _: [AnyMusicStaffViewElement] = [MusicClef.bass, MusicClef.treble].map { AnyMusicStaffViewElement($0) }
        let _: [AnyMusicStaffViewElement] = [MusicAccidental.natural].map { AnyMusicStaffViewElement($0) }

        XCTAssertNotNil(MusicAccidental.natural.asAnyMusicStaffViewElement)
        XCTAssertNotNil(MusicAccidental.natural.asAnyMusicStaffViewElement.unboxed as? MusicAccidental)
        let _: [AnyMusicStaffViewElement] = [MusicAccidental.natural.asAnyMusicStaffViewElement, MusicClef.bass.asAnyMusicStaffViewElement]
        
        let _: [any MusicStaffViewElement] = [MusicAccidental.natural, MusicNote(pitch: MusicPitch(name: .c, accidental: .natural, octave: 4), rhythm: .quarter)]
    }
    
    func testNaturalPath() throws {
        let path = MusicAccidental.natural.path(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        
    }
}
