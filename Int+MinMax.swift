//
//  Int+MinMax.swift
//  ORCommonCode-Swift
//
//  Created by Nikita Egoshin on 27.01.2020.
//

import Foundation


extension Int {
    
    static func minimum(a: Int, b: Int) -> Int {
        return (a < b) ? a : b
    }
    
    static func maximum(a: Int, b: Int) -> Int {
        return (a > b) ? a : b
    }
}
