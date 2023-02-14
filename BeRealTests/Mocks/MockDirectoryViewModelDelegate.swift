//
//  MockDirectoryViewModelDelegate.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

@testable import BeReal

final class MockDirectoryViewModelDelegate: DirectoryViewModelDelegate {

    func destinationView(for directory: Directory) -> DirectoryDestinationType? {
        return nil
    }
}
