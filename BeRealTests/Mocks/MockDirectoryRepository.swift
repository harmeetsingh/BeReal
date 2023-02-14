//
//  MockDirectoryRepository.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

@testable import BeReal

final class MockDirectoryRepository: DirectoryRepository {

    private(set) var fetchSubDirectoriesCalls = [Directory]()
    var fetchSubDirectoriesStub: [Directory]?
    
    func fetchSubDirectories(in directory: Directory) async throws -> [Directory] {
        fetchSubDirectoriesCalls.append(directory)
        
        if let directories = fetchSubDirectoriesStub {
            return directories
        } else {
            throw MockError.instance
        }
    }
}
