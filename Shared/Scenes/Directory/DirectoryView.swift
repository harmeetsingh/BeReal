//
//  DirectoryView.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import SwiftUI

struct DirectoryView<ViewModel>: View where ViewModel: DirectoryViewModelType {

    @StateObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.viewState {
        case .empty:
            Text("This directory is empty.")
        case .loading:
            loadingView
                .onAppear { Task { await viewModel.onAppear() } }
        case .loaded:
            loadedView
        case .failed(let error):
            Text("An error occured, please try again later.")
                .alert(error.localizedDescription, isPresented: $viewModel.isAlertPresented) {
                    Button("Okay") {
                        viewModel.dismissAlert()
                    }
                }
        }
    }

    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
    
    private var loadedView: some View {
        VStack {
            Text(viewModel.description)
                .font(.body)
            Text(viewModel.lastModificationDate)
                .font(.subheadline)
            Spacer()
            List {
                ForEach(viewModel.directories) { directory in
                    NavigationLink {
                        if let destinationView = viewModel.destinationViewModel(for: directory) {
                            switch destinationView {
                            case .directory(let directoryView):
                                directoryView
                            case .image(let imageDetailsView):
                                imageDetailsView
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: directory.systemImageName)
                            VStack(alignment: .leading) {
                                Text(directory.name)
                                Text(directory.formattedDate)
                            }
                        }
                    }
                }
            }
        }
    }
}
