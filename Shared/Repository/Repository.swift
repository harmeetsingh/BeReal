//
//  Repository.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol RepositoryType: UserRepository, DirectoryRepository, ImageRepository { }

final class Repository: RepositoryType {

    let networkSession: NetworkSessionType
    
    init(networkSession: NetworkSessionType) {
        self.networkSession = networkSession
    }
}
