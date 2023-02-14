//
//  MockURLSessionProvider.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

@testable import BeReal
import Foundation

final class MockURLSessionProvider: URLSessionProviding {
    
    private(set) var dataCalls = [URLRequest]()
    var dataStub: (Data, URLResponse)?
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataCalls.append(request)
        
        if let dataStub = dataStub {
            return dataStub
        } else {
            throw MockError.instance
        }
    }
}
