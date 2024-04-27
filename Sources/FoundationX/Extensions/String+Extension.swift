//
//  String+Extension.swift
//  Loop
//
//  Created by longvu on 15/02/2022.
//

import Foundation

extension String: LocalizedError {
    // can throw string as error
    public var errorDescription: String? { return self }
}

public extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}

public extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: 0, length: self.utf16.count)
        ) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
