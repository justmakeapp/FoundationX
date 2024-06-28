//
//  L10nValue.swift
//
//
//  Created by Long Vu on 1/5/24.
//

import Foundation

public struct L10nValue: Decodable, Equatable, Sendable {
    public let key: String?
    public let tableName: String?
    public let bundle: String?
    private let args: [UncheckedSendable<CVarArg>]?
    public let fallback: String

    public func asString(_ withBundle: (_ bundleString: String?) -> Bundle) -> String {
        if let key {
            let format = NSLocalizedString(
                key,
                tableName: tableName,
                bundle: withBundle(bundle),
                value: fallback,
                comment: ""
            )
            let arguments: [any CVarArg] = (args ?? []).map(\.wrappedValue)
            return String(format: format, locale: Locale.current, arguments: arguments)
        }
        return fallback
    }

    enum CodingKeys: String, CodingKey {
        case key
        case tableName
        case bundle
        case args
        case fallback
    }

    public init(
        key: String?,
        tableName: String?,
        bundle: String?,
        args: [CVarArg],
        fallback: String
    ) {
        self.key = key
        self.tableName = tableName
        self.bundle = bundle
        self.args = args.map { UncheckedSendable($0) }
        self.fallback = fallback
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.key = try container.decodeIfPresent(String.self, forKey: .key)

        self.tableName = try container.decodeIfPresent(String.self, forKey: .tableName)

        self.bundle = try container.decodeIfPresent(String.self, forKey: .bundle)

        if let fallback = try container.decodeIfPresent(String.self, forKey: .fallback) {
            self.fallback = fallback
        } else {
            throw NSError(
                domain: "",
                code: 1_000,
                userInfo: [NSLocalizedDescriptionKey: "Can not decode fallback property"]
            )
        }

        if container.contains(.args) {
            var argsContainer = try container.nestedUnkeyedContainer(forKey: .args)

            var args: [CVarArg] = []

            while !argsContainer.isAtEnd {
                if let intValue = try? argsContainer.decode(Int.self) {
                    args.append(intValue)
                }

                if let doubleValue = try? argsContainer.decode(Double.self) {
                    args.append(doubleValue)
                }

                if let stringValue = try? argsContainer.decode(String.self) {
                    args.append(stringValue)
                }
            }

            self.args = args.map { UncheckedSendable($0) }
        } else {
            self.args = []
        }
    }

    public static func == (lhs: L10nValue, rhs: L10nValue) -> Bool {
        let keyIsEqual = lhs.key == rhs.key
        let fallbackIsEqual = lhs.fallback == rhs.fallback

        return keyIsEqual && fallbackIsEqual
    }
}
