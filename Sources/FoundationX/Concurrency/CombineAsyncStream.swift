//
//  CombineAsyncStream.swift
//
//
//  Created by Long Vu on 8/6/24.
//
//  Reference: https://trycombine.com/posts/combine-async-sequence-2/

import Combine
import Foundation

public class CombineAsyncStream<Upstream: Publisher>: AsyncSequence where Upstream.Output: Sendable {
    public typealias Element = Upstream.Output
    public typealias AsyncIterator = CombineAsyncStream<Upstream>

    private let stream: AsyncThrowingStream<Upstream.Output, Error>
    private lazy var iterator = stream.makeAsyncIterator()

    private var cancellable: AnyCancellable?

    public init(_ upstream: Upstream) {
        var subscription: AnyCancellable? = nil

        stream = AsyncThrowingStream<Upstream.Output, Error>(Upstream.Output.self) { continuation in
            subscription = upstream
                .handleEvents(
                    receiveCancel: {
                        continuation.finish(throwing: nil)
                    }
                )
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        continuation.finish(throwing: error)
                    case .finished: continuation.finish(throwing: nil)
                    }
                }, receiveValue: { value in
                    continuation.yield(value)
                })
        }

        cancellable = subscription
    }

    public func makeAsyncIterator() -> Self {
        return self
    }
}

extension CombineAsyncStream: AsyncIteratorProtocol {
    public func next() async throws -> Upstream.Output? {
        return try await iterator.next()
    }
}

public extension Publisher where Output: Sendable {
    func asyncStream() -> CombineAsyncStream<Self> {
        return CombineAsyncStream(self)
    }
}
