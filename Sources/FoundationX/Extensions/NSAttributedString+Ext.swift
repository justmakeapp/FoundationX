//
//  NSAttributedString+Ext.swift
//
//
//  Created by Long Vu on 7/7/24.
//

import Foundation
#if canImport(UIKit)
    import UIKit
#endif
#if canImport(AppKit)
    import AppKit
#endif

public extension NSAttributedString {
    var htmlString: String? {
        do {
            let htmlData = try data(
                from: NSRange(location: 0, length: length),
                documentAttributes: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
            )
            return String(data: htmlData, encoding: .utf8)
        } catch {
            print("error:", error)
            return nil
        }
    }

    var rtfString: String? {
        guard let rtfData = try? rtfData() else {
            return nil
        }
        return String(data: rtfData, encoding: .utf8)
    }

    func rtfData() throws -> Data {
        try data(
            from: .init(location: 0, length: length),
            documentAttributes: [
                .documentType: NSAttributedString.DocumentType.rtf,
                .characterEncoding: String.Encoding.utf8
            ]
        )
    }

    #if canImport(UIKit) || canImport(AppKit)
        static func fromString(
            _ stringValue: String,
            documentType: NSAttributedString.DocumentType
        ) -> NSAttributedString? {
            guard
                let stringData = stringValue.data(using: .utf8),
                let attrString = try? NSAttributedString(
                    data: stringData,
                    options: [
                        .documentType: documentType,
                        .characterEncoding: String.Encoding.utf8.rawValue
                    ],
                    documentAttributes: nil
                ) else {
                return nil
            }
            return attrString
        }

        static func makeAttributedText(from text: String) -> NSAttributedString {
            if
                text.lowercased().starts(with: "<!DOCTYPE html".lowercased()),
                let htmlAttributedText = NSAttributedString.fromString(text, documentType: .html),
                let rtfString = htmlAttributedText.rtfString,
                let rtfAttribtedText = NSAttributedString.fromString(rtfString, documentType: .rtf) {
                return rtfAttribtedText
            } else {
                if let rtfAttribtedText = NSAttributedString.fromString(text, documentType: .rtf) {
                    return rtfAttribtedText
                }
                return NSAttributedString(string: text)
            }
        }
    #endif
}
