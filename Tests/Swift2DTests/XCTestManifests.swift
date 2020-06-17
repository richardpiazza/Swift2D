import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PointTests.allTests),
        testCase(RectTests.allTests),
        testCase(SizeTests.allTests),
    ]
}
#endif
