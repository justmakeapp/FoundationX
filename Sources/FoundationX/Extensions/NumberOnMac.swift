//
//  File.swift
//
//
//  Created by Long Vu on 08/12/2022.
//

import Foundation

public extension CGFloat {
    func scaledToMac() -> CGFloat {
        #if targetEnvironment(macCatalyst) || os(macOS)
            return ceil(self * 0.765)
        #else
            return self
        #endif
    }

    func onMac(_ value: CGFloat) -> CGFloat {
        #if targetEnvironment(macCatalyst) || os(macOS)
            return value
        #else
            return self
        #endif
    }
}

public extension Int {
    func scaledToMac() -> Int {
        #if targetEnvironment(macCatalyst) || os(macOS)
            return Int(ceil(Double(self) * 0.765))
        #else
            return self
        #endif
    }

    func onMac(_ value: Int) -> Int {
        #if targetEnvironment(macCatalyst) || os(macOS)
            return value
        #else
            return self
        #endif
    }
}

public extension Double {
    func scaledToMac() -> Double {
        #if targetEnvironment(macCatalyst) || os(macOS)
            return ceil(self * 0.765)
        #else
            return self
        #endif
    }

    func onMac(_ value: Double) -> Double {
        #if targetEnvironment(macCatalyst) || os(macOS)
            return value
        #else
            return self
        #endif
    }
}
