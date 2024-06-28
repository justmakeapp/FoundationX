//
//  File.swift
//
//
//  Created by Long Vu on 28/6/24.
//

import Foundation

struct UncheckedSendable<Value>: @unchecked Sendable {
    var wrappedValue: Value
    init(_ value: Value) {
        self.wrappedValue = value
    }

    public var projectedValue: Self { self }
}
