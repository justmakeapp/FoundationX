//
//  Catalyst+Helper.swift
//
//
//  Created by Long Vu on 11/12/2022.
//

import Foundation

#if canImport(SwiftUI)
    import SwiftUI
#endif

public func switchTargetEnvironment<R>(
    catalyst: @escaping () -> R,
    nonCatalyst: @escaping () -> R
) -> R {
    #if targetEnvironment(macCatalyst)
        return catalyst()
    #else
        return nonCatalyst()
    #endif
}

#if canImport(SwiftUI)
    public func switchTargetEnvironment(
        catalyst: @escaping () -> some View,
        nonCatalyst: @escaping () -> some View
    ) -> some View {
        #if targetEnvironment(macCatalyst)
            return catalyst()
        #else
            return nonCatalyst()
        #endif
    }
#endif

public func onCatalyst(_ callback: @escaping () -> Void) {
    #if targetEnvironment(macCatalyst)
        callback()
    #endif
}

public func onNonCatalyst(_ callback: @escaping () -> Void) {
    #if !targetEnvironment(macCatalyst)
        callback()
    #endif
}
