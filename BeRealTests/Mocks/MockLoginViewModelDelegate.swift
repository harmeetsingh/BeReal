//
//  MockLoginViewModelDelegate.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
@testable import BeReal

final class MockLoginViewModelDelegate: LoginViewModelDelegate {
    
    func destinationView(with user: User) -> DirectoryView<DirectoryViewModel> {
        DirectoryView(
            viewModel: DirectoryViewModel(
                directory: Directory.fake(),
                repository: MockDirectoryRepository(),
                delegate: MockDirectoryViewModelDelegate()
            )
        )
    }
}
