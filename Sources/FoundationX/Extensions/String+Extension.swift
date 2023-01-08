//
//  String+Extension.swift
//  Loop
//
//  Created by longvu on 15/02/2022.
//

import Foundation

extension String: LocalizedError {
    // can throw string as error
    public var errorDescription: String? { return self }
}
