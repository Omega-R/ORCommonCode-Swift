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
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: .none), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: .none), "1")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: .none), "1000")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: .none), "1000000")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: .none), "1000000000")
    }

    func testThousands() {
        let nf = ORNumberFormatter()
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: .thousands), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: .thousands), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: .thousands), "1")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: .thousands), "1000")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: .thousands), "1000000")
    }

    func testMillions() {
        let nf = ORNumberFormatter()
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: .millions), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: .millions), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: .millions), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: .millions), "1")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: .millions), "1000")
    }

    func testBillions() {
        let nf = ORNumberFormatter()
        XCTAssertEqual(nf.stringValue(for: 0, significantUnits: .billions), "0")
        XCTAssertEqual(nf.stringValue(for: 1, significantUnits: .billions), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000, significantUnits: .billions), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000_000, significantUnits: .billions), "0")
        XCTAssertEqual(nf.stringValue(for: 1_000_000_000, significantUnits: .billions), "1")
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
}
