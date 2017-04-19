import XCTest
@testable import RegexTests

XCTMain([
    testCase(MatchTests.allTests),
    testCase(RegexTests.allTests),
    testCase(StringTests.allTests)
])
