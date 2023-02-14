//
//  ImageDetailsCoordinator.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol ImageDetailsCoorindating {
    
    func rootView(with directory: Directory) -> ImageDetailsView<ImageDetailsViewModel>
}

final class ImageDetailsCoorindator: ImageDetailsCoorindating {
    
    private let repository: ImageRepository
    
    init(repository: ImageRepository) {
        self.repository = repository
    }
    
    func rootView(with directory: Directory) -> ImageDetailsView<ImageDetailsViewModel> {
        let viewModel = ImageDetailsViewModel(directory: directory, repository: repository)
        return ImageDetailsView(viewModel: viewModel)
    }
}
