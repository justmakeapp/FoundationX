//
//  File.swift
//
//
//  Created by Long Vu on 08/12/2022.
//

import Foundation

public extension CGFloat {
    func scaledToMacCatalyst() -> CGFloat {
        #if targetEnvironment(macCatalyst)
            return ceil(self * 0.765)
        #else
            return self
        #endif
    }

    func onMacCatalyst(_ value: CGFloat) -> CGFloat {
        #if targetEnvironment(macCatalyst)
            return value
        #else
            return self
        #endif
    }
}

public extension Int {
    func scaledToMacCatalyst() -> Int {
        #if targetEnvironment(macCatalyst)
            return Int(ceil(Double(self) * 0.765))
        #else
            return self
        #endif
    }

    func onMacCatalyst(_ value: Int) -> Int {
        #if targetEnvironment(macCatalyst)
            return value
        #else
            return self
        #endif
    }
}

public extension Double {
    func scaledToMacCatalyst() -> Double {
        #if targetEnvironment(macCatalyst)
            return ceil(self * 0.765)
        #else
            return self
        #endif
    }

    func onMacCatalyst(_ value: Double) -> Double {
        #if targetEnvironment(macCatalyst)
            return value
        #else
            return self
        #endif
    }
}
