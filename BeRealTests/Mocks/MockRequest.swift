//
//  MockRequest.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
@testable import BeReal

struct MockRequest: Request {

    let endpoint: Endpoints = .me
    let method: HTTPMethodType = .get
    let headers: [String : String] = [:]
    var responseContainsFractionalDate: Bool = false
    
    func makeRequest(with host: String, credentials: UserCredentials?) -> URLRequest? {
        return nil
    }
}
