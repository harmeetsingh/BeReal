//
//  URLResponse+Extension.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

extension URLResponse {
    
    var isSuccessful: Bool {
        let statusCode = (self as? HTTPURLResponse)?.statusCode ?? 0
        let range = 200...299
        return range.contains(statusCode)
    }
}
