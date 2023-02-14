//
//  Repository+Directory.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol DirectoryRepository {

    func fetchSubDirectories(in directory: Directory) async throws -> [Directory]
}

extension Repository: DirectoryRepository {
    
    func fetchSubDirectories(in directory: Directory) async throws -> [Directory] {
        let request = DirectoryRequest(directory: directory)
        return try await networkSession.performRequest(request, type: [Directory].self)
    }
}
