// Copyright (c) 2017 Hèctor Marquès Ranea
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import XCTest
@testable import RegexMatcher

class RegexTests: XCTestCase {
    var pattern: String!
    var sut: Regex!
    
    override func setUp() {
        sut = ".{3}"
        pattern = sut.pattern
    }

    func testPatternIsSet() {
        let expectedPattern = ".{3}"
        XCTAssertEqual(sut.pattern, expectedPattern)
    }
    
    func testOptionsIsSet() {
        let expectedOptions = NSRegularExpression.Options(rawValue: 0)
        XCTAssertEqual(sut.options, expectedOptions)
    }
    
    func testMatchingOptionsIsSet() {
        let expectedMatchingOptions = NSRegularExpression.MatchingOptions(rawValue: 0)
        XCTAssertEqual(sut.matchingOptions, expectedMatchingOptions)
    }
    
    func testEqualityReturnsTrue() {
        let otherRegex = try! Regex(pattern: pattern, options: [], matchingOptions: [])
        XCTAssertEqual(sut, otherRegex)
    }

    func testEqualityReturnsFalseWhenPatternsDiffer() {
        let otherPattern = "[.]{3}"
        let otherRegex = try! Regex(pattern: otherPattern, options: [], matchingOptions: [])
        XCTAssertNotEqual(sut, otherRegex)
    }

    func testEqualityReturnsFalseWhenOptionsDiffer() {
        let otherRegex = try! Regex(pattern: pattern, options: [.allowCommentsAndWhitespace])
        XCTAssertNotEqual(sut, otherRegex)
    }
    
    func testEqualityReturnsFalseWhenMatchingOptionsDiffer() {
        let otherRegex = try! Regex(pattern: pattern, matchingOptions: [.reportProgress])
        XCTAssertNotEqual(sut, otherRegex)
    }
    
    func testExpressibleByStringLiteralConformance() {
        let otherRegex = try! Regex(pattern: pattern)
        XCTAssertEqual(sut, otherRegex)
    }
    
    func testMatches() {
        let expectedValues = ["som", "e s", "tri", "som", "e s", "tri"]
        let string = "some string\nsome string"
        let matches = sut.matches(in: string)
        let values = matches.map { $0.value }
        XCTAssertEqual(values, expectedValues)
    }
    
    func testMatchesWithCapturingGroups() {
        sut = "([a-z]([a-z]) )"
        let expectedGroups = ["me ", "e"]
        let string = "some string"
        let matches = sut.matches(in: string)
        let capturedGroups = matches
            .flatMap { $0.capturedRanges }
            .compactMap { $0 }
            .map { String(string[$0]) }
        XCTAssertEqual(capturedGroups, expectedGroups)
    }

    func testMatchesWithOptions() {
        sut = try! Regex(pattern: pattern, options: [.dotMatchesLineSeparators])
        let expectedValues = ["som", "e s", "tri", "ng\n", "som", "e s", "tri"]
        let string = "some string\nsome string"
        let matches = sut.matches(in: string)
        let values = matches.map { $0.value }
        XCTAssertEqual(values, expectedValues)
    }
    
    func testNumberOfMatches() {
        let expectedNumber = 6
        let string = "some string\nsome string"
        let number = sut.numberOfMatches(in: string)
        XCTAssertEqual(number, expectedNumber)
    }
    
    func testNumberOfMatchesWithOptions() {
        sut = try! Regex(pattern: pattern, options: [.dotMatchesLineSeparators])
        let expectedNumber = 7
        let string = "some string\nsome string"
        let number = sut.numberOfMatches(in: string)
        XCTAssertEqual(number, expectedNumber)
    }
    
    static var allTests = [
        ("testPatternIsSet", testPatternIsSet),
        ("testOptionsIsSet", testOptionsIsSet),
        ("testMatchingOptionsIsSet", testMatchingOptionsIsSet),
        ("testEqualityReturnsTrue", testEqualityReturnsTrue),
        ("testEqualityReturnsFalseWhenPatternsDiffer", testEqualityReturnsFalseWhenPatternsDiffer),
        ("testEqualityReturnsFalseWhenOptionsDiffer", testEqualityReturnsFalseWhenOptionsDiffer),
        ("testEqualityReturnsFalseWhenMatchingOptionsDiffer", testEqualityReturnsFalseWhenMatchingOptionsDiffer),
        ("testExpressibleByStringLiteralConformance", testExpressibleByStringLiteralConformance),
        ("testMatches", testMatches),
        ("testMatchesWithOptions", testMatchesWithOptions),
        ("testMatchesWithCapturingGroups", testMatchesWithCapturingGroups),
        ("testNumberOfMatches", testNumberOfMatches),
        ("testNumberOfMatchesWithOptions", testNumberOfMatchesWithOptions)
    ]
}
