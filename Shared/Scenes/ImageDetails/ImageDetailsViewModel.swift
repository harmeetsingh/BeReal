//
//  ImageDetailsViewModel.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol ImageDetailsViewModelType: ObservableObject {
 
    var description: String { get }
    var lastModificationDate: String { get }
    var imageData: Data? { get }
    var viewState: ImageDetailsViewState { get }
    var isAlertPresented: Bool { get set }
    
    func onAppear()
    func dismissAlert()
}

final class ImageDetailsViewModel: ImageDetailsViewModelType {

    var description: String {
        "Image name: \(directory.name)"
    }
    
    var lastModificationDate: String {
        "Last modified: \(directory.formattedDate)"
    }

    @Published private(set) var imageData: Data?
    @Published private(set) var viewState: ImageDetailsViewState = .loading
    @Published var isAlertPresented: Bool = false
    
    private let directory: Directory
    private let repository: ImageRepository
    
    init(directory: Directory, repository: ImageRepository) {
        self.directory = directory
        self.repository = repository
    }
    
    func onAppear() {
        Task {
            do {
                imageData = try await repository.fetchImage(in: directory)
                viewState = .loaded
            } catch let error {
                viewState = .failed(error)
                isAlertPresented = true
            }
        }
    }
    
    func dismissAlert() {
        viewState = .loaded
        isAlertPresented = false
    }
}
