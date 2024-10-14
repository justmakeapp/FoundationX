//
//  ProcessInfo+Ext.swift
//  FoundationX
//
//  Created by Long Vu on 14/10/24.
//

import Foundation

public extension ProcessInfo {
    var isXcodePreview: Bool {
        environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
