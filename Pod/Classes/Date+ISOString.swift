//
//  Date+ISOString.swift
//  Pods
//
//  Created by Maxim Soloviev on 29/01/16.
//
//

import Foundation

extension Date {
    
    static private var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(abbreviation: "GMT")
        df.dateStyle = .medium
        df.timeStyle = .medium
        
        return df
    } ()
    
    public static func or_dateFromISOString(_ string: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: string)
    }
    
    public static func or_ISOStringFromDate(_ date: Date) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: date) + "Z"
    }
}
