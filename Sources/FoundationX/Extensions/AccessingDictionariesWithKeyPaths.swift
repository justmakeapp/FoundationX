//
//  AccessingDictionariesWithKeyPaths.swift
//
//
//  Created by Long Vu on 03/05/2023.
//

/*
 Thanks for @olebegemann
 code of keypath from this link
 https://oleb.net/blog/2017/01/dictionary-key-paths/
 */

import Foundation

public struct KeyPath {
    public var segments: [String]

    public var isEmpty: Bool { return segments.isEmpty }
    public var path: String {
        return segments.joined(separator: ".")
    }

    /// Strips off the first segment and returns a pair
    /// consisting of the first segment and the remaining key path.
    /// Returns nil if the key path has no segments.
    public func headAndTail() -> (head: String, tail: KeyPath)? {
        guard !isEmpty else { return nil }
        var tail = segments
        let head = tail.removeFirst()
        return (head, KeyPath(segments: tail))
    }
}

/// Initializes a KeyPath with a string of the form "this.is.a.keypath"
public extension KeyPath {
    init(_ string: String) {
        segments = string.components(separatedBy: ".")
    }
}

/// Initializes a KeyPath with a string of the form "this.is.a.keypath"
extension KeyPath: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(value)
    }
}

public extension Dictionary where Key == String {
    subscript(keyPath keyPath: KeyPath) -> Any? {
        get {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty.
                return nil
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                // Reached the end of the key path.
                let key = head
                return self[key]
            case let (head, remainingKeyPath)?:
                // Key path has a tail we need to traverse.
                let key = head
                switch self[key] {
                case let nestedDict as [Key: Any]:
                    // Next nest level is a dictionary.
                    // Start over with remaining key path.
                    return nestedDict[keyPath: remainingKeyPath]
                default:
                    // Next nest level isn't a dictionary.
                    // Invalid key path, abort.
                    return nil
                }
            }
        }
        // ...
        set {
            switch keyPath.headAndTail() {
            case nil:
                // key path is empty.
                return
            case let (head, remainingKeyPath)? where remainingKeyPath.isEmpty:
                // Reached the end of the key path.
                let key = head
                self[key] = newValue as? Value
            case let (head, remainingKeyPath)?:
                let key = head
                let value = self[key]
                switch value {
                case var nestedDict as [Key: Any]:
                    // Key path has a tail we need to traverse
                    nestedDict[keyPath: remainingKeyPath] = newValue
                    self[key] = nestedDict as? Value
                default:
                    // Invalid keyPath
                    return
                }
            }
        }
    }
}
