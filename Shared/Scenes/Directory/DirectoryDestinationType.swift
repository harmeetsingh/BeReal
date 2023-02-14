//
//  DirectoryDestinationType.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

enum DirectoryDestinationType {
    
    case directory(DirectoryView<DirectoryViewModel>)
    case image(ImageDetailsView<ImageDetailsViewModel>)
}
