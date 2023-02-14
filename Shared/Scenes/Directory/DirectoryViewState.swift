import Foundation

enum DirectoryViewState: Equatable {
    
    case empty
    case loading
    case loaded
    case failed(Error)
    
    static func == (lhs: DirectoryViewState, rhs: DirectoryViewState) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
