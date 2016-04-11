//
//  NSString+Extended.swift
//  Pods
//
//  Created by Maxim Soloviev on 11/04/16.
//
//

import Foundation

extension String {
    
    var or_length: Int {
        get {
            return self.characters.count
        }
    }
    
    func or_estimatedSize(font: UIFont, maxWidth: CGFloat?, maxHeight: CGFloat?) -> CGSize {
        
        let fontAttributes: [String : AnyObject] = [NSFontAttributeName : font];
        let maxSize: CGSize = CGSize(width: maxWidth ?? CGFloat.max, height: maxHeight ?? CGFloat.max);
        let boundingRect: CGRect = self.boundingRectWithSize(maxSize,
                                                             options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                             attributes: fontAttributes,
                                                             context: nil);
        
        return boundingRect.size;
    }
    
    static func or_uniqueString() -> String {
        let uuid: String = NSUUID().UUIDString;
        
        return uuid.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "-"));
    }
    
    static func or_localized(keyStr: String) -> String {
        return NSLocalizedString(keyStr, comment: "")
    }
    
    func or_isFileURL() -> Bool {
        return self.or_matchesForRegexInText("^file:///").count > 0
    }
    
    func or_repeatString(n:Int) -> String {
        if (n < 1) {
            return ""
        }
        
        var result = self
        for _ in 1 ..< n {
            result.appendContentsOf(self)
        }
        return result
    }
    
    mutating func or_appendToChain(other: String?, separator: String = " ") {
        guard let strToAdd = other else { return }
        self = (self.or_length > 0) ? "\(self)\(separator)\(strToAdd)" : strToAdd
    }
    
    func or_matchesForRegexInText(regex: String!) -> [NSTextCheckingResult] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = self as NSString
            let results = regex.matchesInString(self, options: [], range: NSMakeRange(0, nsString.length))
            return results
        } catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    func or_withoutFirstAndLastChars() -> String {
        let result = String(self.characters.dropFirst().dropLast())
        return result
    }
    
    func or_sizeWithFont(font: UIFont, maxWidth: CGFloat = CGFloat.max) -> CGSize {
        let size = NSString(string: self).boundingRectWithSize(CGSizeMake(maxWidth, CGFloat.max),
                                                               options: .UsesLineFragmentOrigin,
                                                               attributes: [NSFontAttributeName: font],
                                                               context: nil).size
        let result = CGSizeMake(ceil(size.width), ceil(size.height))
        return result
    }
    
    func or_substringWithRange(range: NSRange) -> String {
        let startIndex = self.startIndex.advancedBy(range.location)
        let endIndex = startIndex.advancedBy(range.length)
        let substringRange = startIndex ..< endIndex
        
        let result = self.substringWithRange(substringRange)
        return result
    }
}
