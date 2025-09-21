//
//  URLSession+Ext.swift
//  FoundationX
//
//  Created by Long Vu on 21/9/25.
//
//  Credit: https://stackoverflow.com/a/79509108

import Foundation

@available(iOS 15.0, macOS 12.0, *)
public extension URLSession {
    enum DownloadStatus {
        case downloading(Double)
        case finished(URL, URLResponse)
    }

    func download(from url: URL) async throws -> AsyncThrowingStream<DownloadStatus, Error> {
        AsyncThrowingStream { continuation in
            Task {
                do {
                    let (localUrl, response) = try await download(
                        from: url,
                        delegate: ProgressObserver { continuation.yield(.downloading($0.fractionCompleted)) }
                    )
                    continuation.yield(.finished(localUrl, response))
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
}

private final class ProgressObserver: NSObject, URLSessionTaskDelegate, @unchecked Sendable {
    private var observation: NSKeyValueObservation?
    private let changeHandler: (Progress) -> Void

    init(changeHandler: @escaping (Progress) -> Void) {
        self.changeHandler = changeHandler
    }

    func urlSession(_: URLSession, didCreateTask task: URLSessionTask) {
        observation = task.progress.observe(\.fractionCompleted) { progress, _ in
            self.changeHandler(progress)
        }
    }
}
