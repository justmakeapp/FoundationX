//
//  AsyncResultOperation.swift
//
//
//  Created by longvu on 24/08/2022.
//

import Foundation

open class AsyncResultOperation<Success, Failure>: AsyncOperation, @unchecked Sendable where Failure: Error {
    public private(set) var result: Result<Success, Failure>! {
        didSet {
            onResult?(result)
        }
    }

    public var onResult: ((_ result: Result<Success, Failure>) -> Void)?

    override public final func finish() {
        guard !isCancelled else { return super.finish() }
        fatalError("Make use of finish(with:) instead to ensure a result")
    }

    public func finish(with result: Result<Success, Failure>) {
        self.result = result
        super.finish()
    }

    override open func cancel() {
        fatalError("Make use of cancel(with:) instead to ensure a result")
    }

    public func cancel(with error: Failure) {
        result = .failure(error)
        super.cancel()
    }
}
