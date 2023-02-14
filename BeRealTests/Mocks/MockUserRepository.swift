//
//  MockUserRepository.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

@testable import BeReal

final class MockUserRepository: UserRepository {
    
    private(set) var fetchUserCalls = [UserCredentials]()
    var fetchUserStub: User?

    func fetchUser(with credentials: UserCredentials) async throws -> User {
        fetchUserCalls.append(credentials)

        if let fetchUserStub = fetchUserStub {
            return fetchUserStub
        } else {
            throw MockError.instance
        }
    }
}
