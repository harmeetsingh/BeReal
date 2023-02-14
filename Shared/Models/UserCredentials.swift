//
//  UserCredentials.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

struct UserCredentials: Equatable {
    
    let username: String
    let password: String
    
    var encodedCredentials: String {
        let credentials = "\(username):\(password)"
        let credentialsData = credentials.data(using: .utf8)
        return credentialsData?.base64EncodedString() ?? ""
    }
}
