//
//  NumberOnVision.swift
//
//
//  Created by Long Vu on 4/7/24.
//

import Foundation

public extension CGFloat {
    func onVision(_ value: CGFloat) -> CGFloat {
        #if os(visionOS)
            return value
        #else
            return self
        #endif
    }
}

public extension Int {
    func onVision(_ value: Int) -> Int {
        #if os(visionOS)
            return value
        #else
            return self
        #endif
    }
}

public extension Double {
    func onVision(_ value: Double) -> Double {
        #if os(visionOS)
            return value
        #else
            return self
        #endif
    }
}
