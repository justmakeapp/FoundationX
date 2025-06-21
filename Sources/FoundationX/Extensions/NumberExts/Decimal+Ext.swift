//
//  Decimal+Ext.swift
//  FoundationX
//
//  Created by Long Vu on 21/6/25.
//

import Foundation

public extension Decimal {
    var doubleValue: Double {
        Double(truncating: self as NSNumber)
    }
}
