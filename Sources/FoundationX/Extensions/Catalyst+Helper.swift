//
//  File.swift
//
//
//  Created by Long Vu on 11/12/2022.
//

import Foundation

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
