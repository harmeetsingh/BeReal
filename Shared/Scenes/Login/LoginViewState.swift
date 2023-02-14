//
//  LoginViewState.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
import SwiftUI

enum LoginViewState: Equatable {
    
    case idle
    case loading
    case loaded
    case failed(Error)
    
    static func == (lhs: LoginViewState, rhs: LoginViewState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
