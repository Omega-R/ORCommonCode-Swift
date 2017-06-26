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
        var comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 1)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringShort(), "1m")

        value = TimeInterval(61)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 1)
        XCTAssertEqual(comp.seconds, 1)
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringShort(), "1m")

        value = TimeInterval(120)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 2)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringShort(), "2m")
        
        value = TimeInterval(3_600)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 1)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringShort(), "1h")

        value = TimeInterval(3_660)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 1)
        XCTAssertEqual(comp.minutes, 1)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringShort(), "1h 1m")

        value = TimeInterval(36_000)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 10)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringShort(), "10h")
        
        value = TimeInterval(86_400)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 1)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringShort(), "1d")
    }
    
    func testSeconds() {
        let value = TimeInterval(1)
        let comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(comp.seconds, 1)
        XCTAssertEqual(comp.milliseconds, 0)
    }
    
    func testMilliseconds() {
        var value = TimeInterval(0.1)
        var comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 100)
        XCTAssertEqual(value.or_timeStringHMSMsec(), "0:00:00.100")
        
        value = TimeInterval(0.108)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        XCTAssertEqual(comp.seconds, 0)
        XCTAssertEqual(comp.milliseconds, 108)
        XCTAssertEqual(value.or_timeStringHMSMsec(), "0:00:00.108")

        value = TimeInterval(0.1080)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.milliseconds, 108)
        XCTAssertEqual(value.or_timeStringHMSMsec(), "0:00:00.108")

        value = TimeInterval(0.001)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.milliseconds, 1)
        XCTAssertEqual(value.or_timeStringHMSMsec(), "0:00:00.001")

        value = TimeInterval(0.0001)
        comp = value.or_timeComponents()
        XCTAssertEqual(comp.milliseconds, 0)
        XCTAssertEqual(value.or_timeStringHMSMsec(), "0:00:00.000")
    }
    
    func testZeroMinutes() {
        let comp = TimeInterval(0).or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        
        XCTAssertEqual(TimeInterval(0).or_timeStringShort(), "0m")
    }
    
    func testNegative() {
        let comp = TimeInterval(-1).or_timeComponents()
        XCTAssertEqual(comp.days, 0)
        XCTAssertEqual(comp.hours, 0)
        XCTAssertEqual(comp.minutes, 0)
        
        XCTAssertEqual(TimeInterval(0).or_timeStringShort(), "0m")
    }
}
