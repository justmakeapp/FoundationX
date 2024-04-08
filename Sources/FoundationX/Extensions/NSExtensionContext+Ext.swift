//
//  File.swift
//
//
//  Created by Long Vu on 8/4/24.
//

import Foundation

/// fix warning: Capture of 'extensionContext' with non-sendable type 'NSExtensionContext' in a `@Sendable` closure
extension NSExtensionContext: @unchecked Sendable {}
