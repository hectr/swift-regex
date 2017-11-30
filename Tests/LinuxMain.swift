import XCTest
@testable import RegexMatcherTests

XCTMain([
    testCase(MatchTests.allTests),
    testCase(RegexTests.allTests),
    testCase(StringTests.allTests)
])
