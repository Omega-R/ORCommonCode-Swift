//
//  AverageValueCalculatorTests.swift
//  ORCommonCode-Swift
//
//  Created by Maxim Soloviev on 07/20/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import ORCommonCode_Swift

class AverageValueCalculatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNormal() {
        let values = [5, 10, 15]
        let avgCalc = ORMath.AverageValueCalculator()
        values.forEach({ avgCalc.addValue(Double($0)) })
        XCTAssertEqual(avgCalc.avgValue, 10)
        
        avgCalc.reset()
        XCTAssertEqual(avgCalc.avgValue, 0)

        values.forEach({ avgCalc.addValue(Double($0)) })
        XCTAssertEqual(avgCalc.avgValue, 10)
    }

    func testEmpty() {
        let avgCalc = ORMath.AverageValueCalculator()
        XCTAssertEqual(avgCalc.avgValue, 0)
    }
    
    func testZero() {
        let values = [0, 0, 0]
        let avgCalc = ORMath.AverageValueCalculator()
        values.forEach({ avgCalc.addValue(Double($0)) })
        XCTAssertEqual(avgCalc.avgValue, 0)
    }
}
