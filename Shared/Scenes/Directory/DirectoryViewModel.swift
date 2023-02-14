import SwiftUI

protocol DirectoryViewModelType: ObservableObject {
    
    var description: String { get }
    var lastModificationDate: String { get }
    var viewState: DirectoryViewState { get }
    var directories: [Directory] { get }
    var isAlertPresented: Bool { get set }
    
    func onAppear() async
    func destinationViewModel(for directory: Directory) -> DirectoryDestinationType?
    func dismissAlert()
}

protocol DirectoryViewModelDelegate: AnyObject {
    
    func destinationView(for directory: Directory) -> DirectoryDestinationType?
}

final class DirectoryViewModel: DirectoryViewModelType {
    
    @Published var viewState: DirectoryViewState = .loading
    @Published var directories: [Directory] = []
    @Published var isAlertPresented: Bool = false
    
    private let directory: Directory
    private let repository: DirectoryRepository
    private weak var delegate: DirectoryViewModelDelegate?

    var description: String {
        "Current directory: \(directory.name.capitalizingFirstLetter())"
    }
    
    var lastModificationDate: String {
        "Last modified: \(directory.formattedDate)"
    }
    
    init(
        directory: Directory,
        repository: DirectoryRepository,
        delegate: DirectoryViewModelDelegate
    ) {
        self.directory = directory
        self.repository = repository
        self.delegate = delegate
    }
    
    func onAppear() async {
        do {
            directories = try await repository.fetchSubDirectories(in: directory)
            viewState = directories.isEmpty ? .empty : .loaded
        } catch let error {
            viewState = .failed(error)
            isAlertPresented = true
        }
    }
    
    func destinationViewModel(for directory: Directory) -> DirectoryDestinationType? {
        delegate?.destinationView(for: directory)
    }
    
    func dismissAlert() {
        viewState = .loaded
        isAlertPresented = false
    }
}
