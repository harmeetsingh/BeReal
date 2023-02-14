//
//  LoginViewModel.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
import SwiftUI

protocol LoginViewModelType: ObservableObject {
    
    var username: String { get set }
    var password: String { get set }
    var isAlertPresented: Bool { get set }
    var viewState: LoginViewState { get }
    var destinationView: DirectoryView<DirectoryViewModel>? { get }
    
    func login() async
    func dismissAlert()
}

protocol LoginViewModelDelegate: AnyObject {
    
    func destinationView(with user: User) -> DirectoryView<DirectoryViewModel>
}

final class LoginViewModel: LoginViewModelType {

    @Published var username: String = "" // noel
    @Published var password: String = "" // foobar
    @Published var viewState: LoginViewState = .idle
    @Published var isAlertPresented: Bool = false
    @Published var destinationView: DirectoryView<DirectoryViewModel>?

    private let repository: UserRepository
    private weak var delegate: LoginViewModelDelegate?
    private var dispatchQueue: DispatchQueue
    
    init(
        repository: UserRepository,
        delegate: LoginViewModelDelegate,
        dispatchQueue: DispatchQueue = DispatchQueue.main
    ) {
        self.repository = repository
        self.delegate = delegate
        self.dispatchQueue = dispatchQueue
    }

    // TODO: Find a way to remove async from this function
    // The async aspect is an implementation detail and should not force the caller to implemment await
    func login() async {
        viewState = .loading
        let credentials = UserCredentials(username: username, password: password)

        do {
            let user = try await self.repository.fetchUser(with: credentials)
            if let destinationView = self.delegate?.destinationView(with: user) {
                self.viewState = .loaded
                self.destinationView = destinationView
            }
        } catch let error {
            self.viewState = .failed(error)
            self.isAlertPresented = true
        }
    }
    
    func dismissAlert() {
        viewState = .idle
        isAlertPresented = false
    }
}
