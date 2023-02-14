//
//  UserRequest.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

struct UserRequest: Request, Equatable {

    let userCredentials: UserCredentials
    let endpoint: Endpoints = .me
    let method: HTTPMethodType = .get

    var headers: [String : String] {
        [Constants.authorizationKey : "Basic \(userCredentials.encodedCredentials)"]
    }
}
