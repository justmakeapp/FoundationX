//
//  UncheckedSendable.swift
//
//
//  Created by Long Vu on 28/6/24.
//

import Foundation

public struct UncheckedSendable<Value>: @unchecked Sendable {
    public var wrappedValue: Value
    public init(_ value: Value) {
        wrappedValue = value
    }

    public var projectedValue: Self { self }
}
