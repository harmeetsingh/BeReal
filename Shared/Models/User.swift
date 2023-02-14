//
//  User.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

struct User: Codable, Equatable {
    
    let firstName: String
    let lastName: String
    let rootItem: Directory // TODO: Improve variable name to directory
}
