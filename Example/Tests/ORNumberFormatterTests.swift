//
//  ORNumberFormatterTests.swift
//  ORCommonCode-Swift
//
//  Created by Maxim Soloviev on 31/10/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import ORCommonCode_Swift

class ORNumberFormatterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNone() {
        let nf = ORNumberFormatter()
        let significantUnits = ORNumberFormatter.SignificantUnits.none
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: significantUnits), "1")
        XCTAssertEqual(nf.stringValue(for: 999, significantUnits: significantUnits), "999")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: significantUnits), "1000")
        XCTAssertEqual(nf.stringValue(for: 999_999, significantUnits: significantUnits), "999999")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: significantUnits), "1000000")
        XCTAssertEqual(nf.stringValue(for: 999_999_999, significantUnits: significantUnits), "999999999")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: significantUnits), "1000000000")
    }

    func testThousands() {
        let nf = ORNumberFormatter()
        let significantUnits = ORNumberFormatter.SignificantUnits.thousands
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 999, significantUnits: significantUnits), "0.9")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: significantUnits), "1")
        XCTAssertEqual(nf.stringValue(for: 999_999, significantUnits: significantUnits), "999.9")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: significantUnits), "1000")
        XCTAssertEqual(nf.stringValue(for: 999_999_999, significantUnits: significantUnits), "999999.9")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: significantUnits), "1000000")
    }

    func testMillions() {
        let nf = ORNumberFormatter()
        let significantUnits = ORNumberFormatter.SignificantUnits.millions
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 999, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 999_999, significantUnits: significantUnits), "0.9")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: significantUnits), "1")
        XCTAssertEqual(nf.stringValue(for: 999_999_999, significantUnits: significantUnits), "999.9")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: significantUnits), "1000")
    }

    func testBillions() {
        let nf = ORNumberFormatter()
        let significantUnits = ORNumberFormatter.SignificantUnits.billions
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 999, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 999_999, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: significantUnits), "0")
        XCTAssertEqual(nf.stringValue(for: 999_999_999, significantUnits: significantUnits), "0.9")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: significantUnits), "1")
    }
    
    func testFractionDigits() {
        let nf = ORNumberFormatter()
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: .none, maxFractionDigits: 0), "0")
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: .none, maxFractionDigits: 5), "0")
        
        XCTAssertEqual(nf.stringValue(for: 0.9, significantUnits: .none, maxFractionDigits: 0), "0")
        XCTAssertEqual(nf.stringValue(for: 0.9, significantUnits: .none, maxFractionDigits: 1), "0.9")
        XCTAssertEqual(nf.stringValue(for: 0.9, significantUnits: .none, maxFractionDigits: 2), "0.9")
        
        XCTAssertEqual(nf.stringValue(for: 0.99, significantUnits: .none, maxFractionDigits: 1), "0.9")
    }
    
    func testAuto() {
        let nf = ORNumberFormatter()
        var res = nf.autoStringValue(for: 999)
        XCTAssertEqual(res.strValue, "999")
        XCTAssertEqual(res.significantUnits, ORNumberFormatter.SignificantUnits.none)
        XCTAssertEqual(nf.autoStringValueWithUnits(for: 999), "999")

        res = nf.autoStringValue(for: 999_999, maxFractionDigits: 0)
        XCTAssertEqual(res.strValue, "999")
        XCTAssertEqual(res.significantUnits, ORNumberFormatter.SignificantUnits.thousands)
        XCTAssertEqual(nf.autoStringValueWithUnits(for: 999_999, maxFractionDigits: 0), "999 K")

        res = nf.autoStringValue(for: 999_999, maxFractionDigits: 1)
        XCTAssertEqual(res.strValue, "999.9")
        XCTAssertEqual(res.significantUnits, ORNumberFormatter.SignificantUnits.thousands)
        XCTAssertEqual(nf.autoStringValueWithUnits(for: 999_999, maxFractionDigits: 1), "999.9 K")

        res = nf.autoStringValue(for: 999_999_999, maxFractionDigits: 0)
        XCTAssertEqual(res.strValue, "999")
        XCTAssertEqual(res.significantUnits, ORNumberFormatter.SignificantUnits.millions)
        XCTAssertEqual(nf.autoStringValueWithUnits(for: 999_999_999, maxFractionDigits: 0), "999 M")

        res = nf.autoStringValue(for: 999_999_999, maxFractionDigits: 1)
        XCTAssertEqual(res.strValue, "999.9")
        XCTAssertEqual(res.significantUnits, ORNumberFormatter.SignificantUnits.millions)
        XCTAssertEqual(nf.autoStringValueWithUnits(for: 999_999_999, maxFractionDigits: 1), "999.9 M")
    }
}
