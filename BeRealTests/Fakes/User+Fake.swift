//
//  User+Fake.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
@testable import BeReal

extension User {
    
    static func fake() -> User {
        User(firstName: "John", lastName: "Wick", rootItem: .fake())
    }
}
