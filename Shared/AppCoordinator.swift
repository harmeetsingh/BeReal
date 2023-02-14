//
//  AppCoordinator.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol AppCoordinatoring {
    
    func makeLogin() -> LoginCoordinatoring
}

struct AppCoordinator: AppCoordinatoring {
    
    let networkSession: NetworkSessionType
    let repository: Repository
    
    init() {
        // TODO: Move host into a plist so we can select different environments .e.g prod, UAT, stage, etc
        networkSession = NetworkSession(host: "http://163.172.147.216:8080", sessionProvider: URLSession.shared)
        repository = Repository(networkSession: networkSession)
    }
    
    func makeLogin() -> LoginCoordinatoring {
        LoginCoordinator(repository: repository, directoryCoorindator: makeDirectory())
    }
    
    func makeDirectory() -> DirectoryCoorindating {
        DirectoryCoorindator(repository: repository, imageDetailsCoordinator: makeImageDetails())
    }
    
    func makeImageDetails() -> ImageDetailsCoorindating {
        ImageDetailsCoorindator(repository: repository)
    }
}
