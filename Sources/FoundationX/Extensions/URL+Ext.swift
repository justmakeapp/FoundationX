//
//  URL+Ext.swift
//
//
//  Created by Long Vu on 03/03/2024.
//

import Foundation
import UniformTypeIdentifiers

public extension URL {
    @available(iOS 14.0, *)
    var utType: UTType? {
        let fallback = UTType(filenameExtension: pathExtension)
        do {
            guard
                let typeID = try resourceValues(forKeys: [.typeIdentifierKey]).typeIdentifier,
                let utType = UTType(typeID)
            else {
                return fallback
            }
            return utType
        } catch {
            debugPrint(error)
            return fallback
        }
    }

    @available(iOS 14.0, *)
    var mimeType: String {
        return utType?.preferredMIMEType ?? "application/octet-stream"
    }

    var fileSize: Int64 {
        do {
            let resources = try resourceValues(forKeys: [.fileSizeKey])
            return Int64(resources.fileSize ?? 0)
        } catch {
            print(error)
            return 0
        }
    }

    /// https://stackoverflow.com/a/49072718
    var isValid: Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        let length = absoluteString.utf16.count
        if let match = detector.firstMatch(
            in: absoluteString,
            options: [],
            range: NSRange(location: 0, length: length)
        ) {
            return match.range.length == length
        } else {
            return false
        }
    }
}
