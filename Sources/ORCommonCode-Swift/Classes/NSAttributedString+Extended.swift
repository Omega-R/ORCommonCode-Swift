//
//  NSAttributedString+Extended.swift
//  Pods
//
//  Created by Alexander Kurbanov on 3/30/16.
//
//

import Foundation
import CoreServices

extension NSAttributedString {
    
    public static func or_attrString(text: String, textColor: UIColor?, font: UIFont?, textAlign: NSTextAlignment = NSTextAlignment.center, lineBreakMode: NSLineBreakMode? = NSLineBreakMode.byWordWrapping, tightenLineSpacing: Bool = false, kerningValue: CGFloat?) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        
        if lineBreakMode != nil {
            paragraphStyle.lineBreakMode = lineBreakMode!
        }
        paragraphStyle.alignment = textAlign
        paragraphStyle.lineSpacing = 0
        var attr: [NSAttributedString.Key: Any] = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        if textColor != nil {
            attr[NSAttributedString.Key.foregroundColor] = textColor!
        }
        if font != nil {
            attr[NSAttributedString.Key.font] = font!
        }
        if tightenLineSpacing {
            paragraphStyle.maximumLineHeight = font!.pointSize
        }
        if kerningValue != nil {
            attr[NSAttributedString.Key.kern] = kerningValue!
        }
        
        let string = NSAttributedString(string: text, attributes: attr)
        return string
    }
    
    @objc public static func or_attrStringWithHyperlinks(original: String, attributes: [NSAttributedString.Key: Any] = [:]) -> NSAttributedString {
        let matches = original.or_matchesForRegexInText("\\[(.*?)\\]")
        if ((matches.count % 2) != 0 || matches.count == 0) {
            return NSAttributedString()
        }
        
        let result = NSMutableAttributedString()
        var beginIndex = 0
        let str = original as NSString
        for i in stride(from: 0, to: matches.count, by: 2) {
            let textRange = matches[i].range
            let text = str.substring(with: textRange)
        
            let valueRange = matches[i + 1].range
            let value = str.substring(with: valueRange)
            
            let normalText = NSAttributedString(string: str.substring(with: NSMakeRange(beginIndex, textRange.location - beginIndex)))
            result.append(normalText)
            
            let link = NSMutableAttributedString(string: text.or_withoutFirstAndLastChars())
            link.addAttribute(NSAttributedString.Key.link, value: value.or_withoutFirstAndLastChars(), range: NSMakeRange(0, link.length))
            result.append(link)
        
            beginIndex = valueRange.location + valueRange.length
        }
        let remainingText = NSAttributedString(string: str.substring(with: NSMakeRange(beginIndex, str.length - beginIndex)))
        result.append(remainingText)
        
        result.addAttributes(attributes, range: NSMakeRange(0, result.length))
        return result
    }
    
    func or_insertIcon(_ icon: UIImage, byReplacingCharactersIn range: NSRange) {
        
        let mutStr = self.mutableCopy() as! NSMutableAttributedString
        
        let attributes: [NSAttributedString.Key : Any]
        
        if range.location < self.length {
            attributes = self.attributes(at: range.location, effectiveRange: nil)
        } else {
            attributes = self.attributes(at: 0, effectiveRange: nil)
        }
        
        let fontSize = (attributes[.font] as! UIFont?)?.pointSize ?? 17.0
        let aspectRatio = icon.size.width / icon.size.height
        
        let iconAttachment = NSTextAttachment(data: icon.pngData(), ofType: kUTTypePNG as String)
        iconAttachment.bounds = CGRect(origin: .zero, size: CGSize(width: fontSize * aspectRatio, height: fontSize))
        
        let iconStr = NSAttributedString(attachment: iconAttachment)
    
        if range.location < self.length {
            mutStr.replaceCharacters(in: range, with: iconStr)
        } else {
            mutStr.append(iconStr)
        }
    }
    
    static func or_buildFromComponents(_ components: [Any], with attributes: [NSAttributedString.Key : Any]) -> NSAttributedString {
        return components
            .compactMap({ comp -> NSAttributedString? in
                switch comp {
                case let str as String:
                    let aStr = NSAttributedString(string: str, attributes: attributes)
                    return aStr
                case let str as NSAttributedString:
                    return str
                case let img as UIImage:
                    let fontSize = (attributes[.font] as! UIFont?)?.pointSize ?? 17.0
                    let aspectRatio = img.size.width / img.size.height
                    let iconAttachment = NSTextAttachment(data: img.pngData(), ofType: kUTTypePNG as String)
                    iconAttachment.bounds = CGRect(origin: .zero, size: CGSize(width: fontSize * aspectRatio, height: fontSize))
                    
                    return NSAttributedString(attachment: iconAttachment)
                default:
                    return nil
                }
            })
            .reduce(NSMutableAttributedString(), { (str, part) -> NSMutableAttributedString in
                str.append(part)
                return str
            })
            .copy() as! NSAttributedString
    }
}
