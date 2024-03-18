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
    var mimeType: String {
        return UTType(filenameExtension: pathExtension)?.preferredMIMEType ?? "application/octet-stream"
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
}
