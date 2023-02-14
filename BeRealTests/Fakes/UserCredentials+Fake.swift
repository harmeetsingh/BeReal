//
//  UserCredentials+Fake.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
@testable import BeReal

extension UserCredentials {
    
    static func fake() -> UserCredentials {
        UserCredentials(username: "hello", password: "world")
    }
}
