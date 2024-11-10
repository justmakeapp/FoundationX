//
//  ODRManager.swift
//  MakeFlashcard
//
//  Created by Long Vu on 27/12/2023.
//
// https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/On_Demand_Resources_Guide

import Foundation
import os

#if os(iOS)
    public final class ODRManager {
        public var bundle: Bundle? {
            currentRequest?.bundle
        }

        private(set) var currentRequest: NSBundleResourceRequest?

        private let logger = Logger(
            subsystem: Bundle.main.bundleIdentifier!,
            category: String(describing: ODRManager.self)
        )

        public init() {}

        public func loadOnDemandResources(tags: Set<String>) async throws {
            let resourceRequest = NSBundleResourceRequest(tags: tags)
            currentRequest = resourceRequest

            /// Use conditionallyBeginAccessingResources to check resource availability
            /// grants access if the tags are already on the device.
            let available = await resourceRequest.conditionallyBeginAccessingResources()
            logger.log("Resources are available: \(available)")

            if !available {
                /// If the tags (resources) are not on the device,
                /// the app needs to call beginAccessingResourcesWithCompletionHandler to download them.
                try await resourceRequest.beginAccessingResources()
                logger.log("Resources are downloaded")
            }
        }
    }
#endif
