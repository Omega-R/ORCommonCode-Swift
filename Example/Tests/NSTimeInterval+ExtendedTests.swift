//
//  NSTimeInterval+ExtendedTests.swift
//  Pods
//
//  Created by Maxim Soloviev on 01/04/16.
//
//

import XCTest
import ORCommonCode_Swift

class NSTimeIntervalExtendedTestsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNormal() {
        var value = TimeInterval(60)
        var comp = TimeInterval(value).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 1)
        XCTAssertEqual(TimeInterval(value).or_durationStringShort(), "1m")

        value = TimeInterval(61)
        comp = TimeInterval(value).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 1)
        XCTAssertEqual(TimeInterval(value).or_durationStringShort(), "1m")

        value = TimeInterval(120)
        comp = TimeInterval(value).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 2)
        XCTAssertEqual(TimeInterval(value).or_durationStringShort(), "2m")
        
        value = TimeInterval(3_600)
        comp = TimeInterval(value).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 1)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(TimeInterval(value).or_durationStringShort(), "1h")

        value = TimeInterval(3_660)
        comp = TimeInterval(value).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 1)
        XCTAssertEqual(comp.minutes, 1)
        XCTAssertEqual(TimeInterval(value).or_durationStringShort(), "1h 1m")

        value = TimeInterval(36_000)
        comp = TimeInterval(value).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 10)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(TimeInterval(value).or_durationStringShort(), "10h")
        
        value = TimeInterval(86_400)
        comp = TimeInterval(value).or_durationComponents()
        XCTAssertEqual(comp.days, 1)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(TimeInterval(value).or_durationStringShort(), "1d")
    }
    
    func testZero() {
        let comp = TimeInterval(0).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        
        XCTAssertEqual(TimeInterval(0).or_durationStringShort(), "0m")
    }
    
    func testNegative() {
        let comp = TimeInterval(-1).or_durationComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        
        XCTAssertEqual(TimeInterval(0).or_durationStringShort(), "0m")
    }
}
