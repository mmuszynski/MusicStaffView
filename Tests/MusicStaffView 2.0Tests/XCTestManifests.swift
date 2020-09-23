import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MusicStaffView_2_0Tests.allTests),
    ]
}
#endif
