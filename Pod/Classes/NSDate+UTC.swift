//
//  NSDate+UTC.swift
//  Pods
//
//  Created by Maxim Soloviev on 02/02/16.
//
//

import Foundation

extension NSDate {
    
    public func or_toLocalTime() -> NSDate {
        let tz = NSTimeZone.defaultTimeZone()
        let seconds = tz.secondsFromGMTForDate(self)
        return NSDate(timeInterval: NSTimeInterval(seconds), sinceDate: self)
    }
    
    public func or_toUTC() -> NSDate {
        let tz = NSTimeZone.defaultTimeZone()
        let seconds = -tz.secondsFromGMTForDate(self)
        return NSDate(timeInterval: NSTimeInterval(seconds), sinceDate: self)
    }
}
