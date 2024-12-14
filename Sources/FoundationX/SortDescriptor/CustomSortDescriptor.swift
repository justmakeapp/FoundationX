//
//  CustomSortDescriptor.swift
//
//
//  Created by longvu on 03/01/2024.
//

import Foundation

public struct CustomSortDescriptor<Value> {
    var comparator: (Value, Value) -> ComparisonResult

    public init(comparator: @escaping (Value, Value) -> ComparisonResult) {
        self.comparator = comparator
    }
}

public extension CustomSortDescriptor {
    static func keyPath(_ keyPath: KeyPath<Value, some Comparable>) -> Self {
        Self { rootA, rootB in
            let valueA = rootA[keyPath: keyPath]
            let valueB = rootB[keyPath: keyPath]

            guard valueA != valueB else {
                return .orderedSame
            }

            return valueA < valueB ? .orderedAscending : .orderedDescending
        }
    }
}

public extension Sequence {
    @available(iOS 15.0, macOS 12.0, *)
    func sorted(
        using descriptors: [CustomSortDescriptor<Element>],
        order: SortOrder
    ) -> [Element] {
        sorted { valueA, valueB in
            for descriptor in descriptors {
                let result = descriptor.comparator(valueA, valueB)

                switch result {
                case .orderedSame:
                    // Keep iterating if the two elements are equal,
                    // since that'll let the next descriptor determine
                    // the sort order:
                    break
                case .orderedAscending:
                    return order == .forward
                case .orderedDescending:
                    return order == .reverse
                }
            }

            // If no descriptor was able to determine the sort
            // order, we'll default to false (similar to when
            // using the '<' operator with the built-in API):
            return false
        }
    }

    @available(iOS 15.0, macOS 12.0, *)
    func sorted(
        using descriptors: CustomSortDescriptor<Element>...,
        order: SortOrder = .forward
    ) -> [Element] {
        sorted(using: descriptors, order: order)
    }
}
