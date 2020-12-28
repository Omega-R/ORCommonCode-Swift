import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ORCommonCode_SwiftTests.allTests),
    ]
}
#endif
