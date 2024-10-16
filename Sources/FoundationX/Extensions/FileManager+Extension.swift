//
//  FileManager+Extension.swift
//
//
//  Created by Long Vu on 24/08/2022.
//

import Foundation

public extension FileManager {
    var documentURL: URL {
        if #available(iOS 16.0, macOS 13.0, *) {
            return URL.documentsDirectory
        } else {
            return urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    }

    func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory: ObjCBool = true
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}
