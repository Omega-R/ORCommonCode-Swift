//
//  NSDate+ISOStringTest.swift
//  Pods
//
//  Created by Maxim Soloviev on 29/01/16.
//
//

import XCTest
import ORCommonCode_Swift

class NSDate_ISOStringTest: XCTestCase {
    let timeZone = NSTimeZone(abbreviation: "GMT")!
    let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
    
    override func setUp() {
        calendar.timeZone = timeZone
    }
    
    func test_dateFromISOString() {
        let s = "2016-01-26T09:08:06.517Z"
        let d = NSDate.or_dateFromISOString(s)
        XCTAssertNotNil(d)
        let components = calendar.componentsInTimeZone(timeZone, fromDate: d!)
        XCTAssertEqual(components.year, 2016)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 26)
        XCTAssertEqual(components.hour, 9)
        XCTAssertEqual(components.minute, 8)
        XCTAssertEqual(components.second, 6)
        let second: Float = ceil(Float(components.nanosecond) / 1000000)
        XCTAssertEqual(second, 517)
    }

    func test_dateFromISOString_emptyString() {
        let d = NSDate.or_dateFromISOString("")
        XCTAssertNil(d)
    }

    func test_dateFromISOString_invalidString() {
        var d = NSDate.or_dateFromISOString("2016-01-26T09:08:06.517ZZ")
        XCTAssertNil(d)
        
        d = NSDate.or_dateFromISOString("2016-01-26T09:08:06.517")
        XCTAssertNil(d)
        
        d = NSDate.or_dateFromISOString("201601-26T09:08:06.517Z")
        XCTAssertNil(d)
        
        d = NSDate.or_dateFromISOString("a016-01-26T09:08:06.517Z")
        XCTAssertNil(d)
    }
    
    func test_ISOStringFromDate() {
        let components = NSDateComponents()
        components.year = 2016
        components.month = 1
        components.day = 26
        components.hour = 9
        components.minute = 8
        components.second = 6
        components.nanosecond = 517 * 1000000
        let d = calendar.dateFromComponents(components)
        let s = NSDate.or_ISOStringFromDate(d!)
        XCTAssertEqual(s, "2016-01-26T09:08:06.517Z")
    }

    func test_ISOStringFromDate_1970() {
        let s = NSDate.or_ISOStringFromDate(NSDate(timeIntervalSince1970: 0))
        XCTAssertEqual(s, "1970-01-01T00:00:00.000Z")
    }
}
