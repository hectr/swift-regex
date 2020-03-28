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

class MatchTests: XCTestCase {
    var sut: Match!
    var range: Range<String.Index>!
    var string: String!
    var substring: String!
    
    override func setUp() {
        string  = "some string"
        substring = "e s"
        range = string.range(of: substring)
        sut = Match(range: range, capturedRanges: [], in: string)
    }
    
    func testRangeIsInitialized() {
        XCTAssertEqual(sut.range, range)
    }
    
    func testValueIsInitialized() {
        XCTAssertEqual(sut.value, substring)
    }
    
    func testEqualityReturnsTrue() {
        let otherString  = "mose sgnirt"
        let otherSubstring = "e s"
        let otherRange = otherString.range(of: otherSubstring)
        let otherMatch = Match(range: otherRange!, capturedRanges: [], in: otherString)
        XCTAssertEqual(sut, otherMatch)
    }
    
    func testEqualityReturnsFalseWhenRangesDiffer() {
        let otherString  = "se sg"
        let otherSubstring = "e s"
        let otherRange = otherString.range(of: otherSubstring)
        let otherMatch = Match(range: otherRange!, capturedRanges: [], in: otherString)
        XCTAssertNotEqual(sut, otherMatch)
    }
    
    func testEqualityReturnsFalseWhenValuesDiffer() {
        let otherString  = "emos gnirts"
        let otherSubstring = "s g"
        let otherRange = otherString.range(of: otherSubstring)
        let otherMatch = Match(range: otherRange!, capturedRanges: [], in: otherString)
        XCTAssertNotEqual(sut, otherMatch)
    }
    
    static var allTests = [
        ("testRangeIsInitialized", testRangeIsInitialized),
        ("testValueIsInitialized", testValueIsInitialized),
        ("testEqualityReturnsTrue", testEqualityReturnsTrue),
        ("testEqualityReturnsFalseWhenRangesDiffer", testEqualityReturnsFalseWhenRangesDiffer),
        ("testEqualityReturnsFalseWhenValuesDiffer", testEqualityReturnsFalseWhenValuesDiffer)
    ]
}
