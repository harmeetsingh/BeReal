//
//  Respository+User.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol UserRepository {
    
    func fetchUser(with credentials: UserCredentials) async throws -> User
}

extension Repository: UserRepository {
    
    func fetchUser(with credentials: UserCredentials) async throws -> User {
        let userRequest = UserRequest(userCredentials: credentials)
        return try await networkSession.performRequest(userRequest, type: User.self)
    }
}
