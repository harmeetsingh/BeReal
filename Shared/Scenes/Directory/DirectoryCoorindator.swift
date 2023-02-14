//
//  DirectoryCoorindator.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol DirectoryCoorindating {
    
    func rootView(with user: User) -> DirectoryView<DirectoryViewModel>
}

final class DirectoryCoorindator: DirectoryCoorindating, DirectoryViewModelDelegate {
    
    private let repository: DirectoryRepository & ImageRepository
    private let imageDetailsCoordinator: ImageDetailsCoorindating
    
    init(
        repository: DirectoryRepository & ImageRepository,
        imageDetailsCoordinator: ImageDetailsCoorindating
    ) {
        self.repository = repository
        self.imageDetailsCoordinator = imageDetailsCoordinator
    }
    
    func rootView(with user: User) -> DirectoryView<DirectoryViewModel> {
        let viewModel = DirectoryViewModel(directory: user.rootItem, repository: repository, delegate: self)
        return DirectoryView(viewModel: viewModel)
    }
    
    func destinationView(for directory: Directory) -> DirectoryDestinationType? {
        if directory.isDir {
            let viewModel = DirectoryViewModel(directory: directory, repository: repository, delegate: self)
            let view = DirectoryView(viewModel: viewModel)
            return .directory(view)
        } else {
            let view = imageDetailsCoordinator.rootView(with: directory)
            return .image(view)
        }
    }
}
