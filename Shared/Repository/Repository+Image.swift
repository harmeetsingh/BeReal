//
//  Repository+Image.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol ImageRepository {
    
    func fetchImage(in directory: Directory) async throws -> Data
}

extension Repository: ImageRepository {
    
    func fetchImage(in directory: Directory) async throws -> Data {
        let request = ImageRequest(directory: directory)
        return try await networkSession.performImageRequest(request)
    }
}
