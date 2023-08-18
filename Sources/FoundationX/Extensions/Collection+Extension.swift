//
//  Collection+Extension.swift
//
//
//  Created by Long Vu on 03/07/2022.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index if it exists, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
