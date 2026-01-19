//
//  DeepLinkFactory.swift
//  AppFoundation
//
//  Created by Long Vu on 18/10/25.
//

import Foundation

public protocol DeepLinkCreating {
    static var scheme: String { get }
    static var host: String { get }
    static var rootPath: String { get }

    static func canHandle(url: URL) -> Bool

    static func makeLink(path: String, queryItems: [URLQueryItem]?) throws -> URL
}

public extension DeepLinkCreating {
    static func makeLink(
        path: String = Self.rootPath,
        queryItems: [URLQueryItem]? = nil
    ) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            throw "Failed to create deep link"
        }

        return url
    }

    static func canHandle(url: URL) -> Bool {
        [
            url.scheme == scheme,
            url.host == host,
            url.path.starts(with: rootPath)
        ]
        .allSatisfy { $0 }
    }
}
