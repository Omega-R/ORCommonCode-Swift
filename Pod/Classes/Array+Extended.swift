//
//  Array+Extended.swift
//  Pods
//
//  Created by Maxim Soloviev on 24/05/16.
//  Copyright © 2016 Maxim Soloviev. All rights reserved.
//

import Foundation

extension Array {
    
    public func or_limitedBySize(_ size: Int, discardingTail: Bool = true) -> [Element] {
        if (self.count <= size) {
            return self
        } else if discardingTail {
            return Array(self[0..<size])
        } else {
            let startIndex = count - size
            return Array(self[startIndex..<count])
        }
    }
}
