//
//  Bundle+Extension.swift
//
//
//  Created by Long Vu on 08/01/2023.
//

import Foundation

public extension Bundle {
    /// Returns the main bundle's version string if available (e.g. 1.0.0)
    var versionString: String? {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    /// Returns the main bundle's build string if available (e.g. 123)
    var buildString: String? {
        return object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }

    /// Application name shown under the application icon.
    var applicationName: String? {
        let cfBundleDisplayName = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        let CFBundleName = object(forInfoDictionaryKey: "CFBundleName") as? String
        return cfBundleDisplayName ?? CFBundleName
    }
}
