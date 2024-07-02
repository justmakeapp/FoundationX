//
//  NumberOnWatch.swift
//
//
//  Created by Long Vu on 2/7/24.
//

import Foundation

public extension CGFloat {
    func onWatch(_ value: CGFloat) -> CGFloat {
        #if os(watchOS)
            return value
        #else
            return self
        #endif
    }
}

public extension Int {
    func onWatch(_ value: Int) -> Int {
        #if os(watchOS)
            return value
        #else
            return self
        #endif
    }
}

public extension Double {
    func onWatch(_ value: Double) -> Double {
        #if os(watchOS)
            return value
        #else
            return self
        #endif
    }
}
