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
