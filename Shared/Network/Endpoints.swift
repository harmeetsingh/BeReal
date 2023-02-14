//
//  Endpoints.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

enum Endpoints: Equatable {
    
    case me
    case items(Directory)
    case download(Directory)
    
    var path: String {
        switch self {
        case .me:
            return "/me"
        case .items(let directory):
            return "/items/\(directory.id)"
        case .download(let directory):
            return "/items/\(directory.id)/data"
        }
    }
}

