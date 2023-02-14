//
//  ImageDetailsView.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import UIKit
import SwiftUI

struct ImageDetailsView<ViewModel>: View where ViewModel: ImageDetailsViewModelType {

    @StateObject var viewModel: ViewModel

    var body: some View {
        switch viewModel.viewState {
        case .loading:
            loadingView
                .onAppear { viewModel.onAppear() }
        case .loaded:
            image
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
    
    private var image: some View {
        VStack {
            Text(viewModel.description)
                .font(.body)
            Text(viewModel.lastModificationDate)
                .font(.subheadline)
            Spacer()
            if let imageData = viewModel.imageData, let image = UIImage(data: imageData) {
                GeometryReader { geo in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                }
            }
        }
    }
}
