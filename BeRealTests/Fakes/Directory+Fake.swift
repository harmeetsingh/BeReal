//
//  Directory+Fake.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
@testable import BeReal

extension Directory {
    
    static func fake() -> Directory {
        Directory(
            id: "1",
            parentId: "2",
            name: "name",
            isDir: false,
            modificationDate: Date()
        )
    }
}
