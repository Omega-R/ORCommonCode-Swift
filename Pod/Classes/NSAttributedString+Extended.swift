//
//  NSAttributedString+Extended.swift
//  InMusik Explorer
//
//  Created by Alexander Kurbanov on 3/30/16.
//  Copyright © 2016 Stone Valley Partners. All rights reserved.
//

import Foundation

extension NSAttributedString {
    
    static func or_stringWithHyperlinks(original: String, attributes: [String : AnyObject] = [:]) -> NSAttributedString {
        let matches = original.or_matchesForRegexInText("\\[(.*?)\\]")
        if ((matches.count % 2) != 0 || matches.count == 0) {
            return NSAttributedString()
        }
        
        let result = NSMutableAttributedString()
        var beginIndex = 0
        let str = original as NSString!
        for i in 0.stride(to: matches.count, by: 2) {
            let textRange = matches[i].range
            let text = str.substringWithRange(textRange)
        
            let valueRange = matches[i + 1].range
            let value = str.substringWithRange(valueRange)
            
            let normalText = NSAttributedString(string: str.substringWithRange(NSMakeRange(beginIndex, textRange.location - beginIndex)))
            result.appendAttributedString(normalText)
            
            let link = NSMutableAttributedString(string: text.or_withoutFirstAndLastChars())
            link.addAttribute(NSLinkAttributeName, value: value.or_withoutFirstAndLastChars(), range: NSMakeRange(0, link.length))
            result.appendAttributedString(link)
        
            beginIndex = valueRange.location + valueRange.length
        }
        let remainingText = NSAttributedString(string: str.substringWithRange(NSMakeRange(beginIndex, str.length - beginIndex)))
        result.appendAttributedString(remainingText)
        
        result.addAttributes(attributes, range: NSMakeRange(0, result.length))
        return result
    }
}
