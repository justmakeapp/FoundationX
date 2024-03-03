//
//  File.swift
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
}
