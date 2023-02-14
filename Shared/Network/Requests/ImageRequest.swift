//
//  ImageRequest.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

struct ImageRequest: Request, Equatable {
    
    let endpoint: Endpoints
    let method: HTTPMethodType = .get
    let headers: [String : String] = [:]
    
    init(directory: Directory) {
        endpoint = .download(directory)
    }
}
