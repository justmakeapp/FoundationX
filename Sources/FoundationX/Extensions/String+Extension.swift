//
//  String+Extension.swift
//  Loop
//
//  Created by longvu on 15/02/2022.
//

import Foundation
#if canImport(NaturalLanguage)
    import NaturalLanguage
#endif
extension String: Foundation.LocalizedError {
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

#if canImport(NaturalLanguage)

    public extension String {
        func splitIntoWords() -> [String] {
            let tokenizer = NLTokenizer(unit: .word)
            tokenizer.string = self
            return tokenizer.tokens(for: startIndex ..< endIndex).map { String(self[$0]) }
        }
    }
#endif

public extension String {
    var containsDigits: Bool {
        return rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }

    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: 0, length: utf16.count)
        ) {
            // it is a link, if the match covers the whole string
            return match.range.length == utf16.count
        } else {
            return false
        }
    }

    // https://sarunw.com/posts/how-to-compare-two-app-version-strings-in-swift/
    func versionCompare(_ otherVersion: String) -> ComparisonResult {
        let versionDelimiter = "."

        var versionComponents = self.components(separatedBy: versionDelimiter)
        var otherVersionComponents = otherVersion.components(separatedBy: versionDelimiter)

        // Then, we find the difference of digit that we will zero pad.
        let zeroDiff = versionComponents.count - otherVersionComponents.count

        // If there are no differences, we don't need to do anything and use simple .compare
        if zeroDiff == 0 {
            // Same format, compare normally
            return self.compare(otherVersion, options: .numeric)
        } else {
            // We populate an array of missing zero.
            let zeros = Array(repeating: "0", count: abs(zeroDiff))
            if zeroDiff > 0 {
                // We add zero pad array to a version with a fewer period and zero.
                otherVersionComponents.append(contentsOf: zeros)
            } else {
                versionComponents.append(contentsOf: zeros)
            }
            return versionComponents.joined(separator: versionDelimiter)
                // We user array components to build back our versions from components and compare them. This time it
                // will have the same period and number of digit.
                .compare(
                    otherVersionComponents.joined(separator: versionDelimiter), options: .numeric
                )
        }
    }
}
