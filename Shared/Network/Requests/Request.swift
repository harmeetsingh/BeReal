//
//  Request.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol Request {

    var endpoint: Endpoints { get }
    var method: HTTPMethodType { get }
    var headers: [String : String] { get }
    var responseContainsFractionalDate: Bool { get }
}

extension Request {

    var responseContainsFractionalDate: Bool { false }
    
    func makeRequest(with host: String, credentials: UserCredentials?) -> URLRequest? {
        
        let urlString = host + endpoint.path
        
        guard !host.isEmpty, let url = URL(string: urlString) else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let credentials = credentials {
            request.addValue("Basic \(credentials.encodedCredentials)", forHTTPHeaderField: Constants.authorizationKey)
        }
        
        return request
    }
}
