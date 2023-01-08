//
//  FileManager+Extension.swift
//
//
//  Created by Long Vu on 24/08/2022.
//

import Foundation

public extension FileManager {
    var documentURL: URL {
        return urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
