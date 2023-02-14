//
//  LoginCoordinator.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import SwiftUI

protocol LoginCoordinatoring {
    
    func rootView() -> LoginView<LoginViewModel>
}

final class LoginCoordinator: LoginCoordinatoring, LoginViewModelDelegate {

    private let repository: UserRepository & DirectoryRepository & ImageRepository
    private let directoryCoorindator: DirectoryCoorindating
    
    init(
        repository: UserRepository & DirectoryRepository & ImageRepository,
        directoryCoorindator: DirectoryCoorindating
    ) {
        self.repository = repository
        self.directoryCoorindator = directoryCoorindator
    }
    
    func rootView() -> LoginView<LoginViewModel> {
        let viewModel = LoginViewModel(repository: repository, delegate: self)
        return LoginView(viewModel: viewModel)
    }

    func destinationView(with user: User) -> DirectoryView<DirectoryViewModel> {
        directoryCoorindator.rootView(with: user)
    }
}
