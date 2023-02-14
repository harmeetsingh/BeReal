//
//  LoginView.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//
import SwiftUI

struct LoginView<ViewModel>: View where ViewModel: LoginViewModelType {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        switch viewModel.viewState {
        case .idle:
            idleView
        case .loading:
            loadingView
        case .loaded:
            viewModel.destinationView
        case .failed(let error):
            idleView
                .alert(error.localizedDescription, isPresented: $viewModel.isAlertPresented) {
                    Button("Okay") {
                        viewModel.dismissAlert()
                    }
                }
        }
    }
    
    private var idleView: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                TextField("Username", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
                SecureField("Password", text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .border(.secondary)
            }
            Button("Login") {
                Task { await viewModel.login() }
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}
