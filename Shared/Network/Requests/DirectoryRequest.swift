//
//  DirectoryRequest.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

struct DirectoryRequest: Request, Equatable {
    
    let endpoint: Endpoints
    let method: HTTPMethodType = .get
    let headers: [String : String]  = [:]
    let responseContainsFractionalDate: Bool = true
    
    init(directory: Directory) {
        endpoint = .items(directory)
    }
}
