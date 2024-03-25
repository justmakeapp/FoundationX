//
//  AsyncCommand.swift
//
//
//  Created by Long Vu on 25/3/24.
//

import Foundation

public protocol Command {
    func cancel()
}

public protocol AsyncCommand: Command {
    func execute() async -> Bool
}

public protocol ThrowableAsyncCommand: Command {
    func execute() async throws -> Bool
}
