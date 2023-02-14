//
//  MockNetworkSession.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation
@testable import BeReal

final class MockNetworkSession: NetworkSessionType {
    
    private(set) var performRequestCalls = [(Request, Any)]()
    var performRequestStub: Decodable? = ""
    
    func performRequest<Model: Decodable>(_ request: Request, type: Model.Type) async throws -> Model {
        performRequestCalls.append((request, type))
        
        if let performRequestStub = performRequestStub as? Model {
            return performRequestStub
        } else {
            throw MockError.instance
        }
    }
    
    private(set) var performImageRequestCalls = [Request]()
    var performImageRequestStub: Data?

    func performImageRequest(_ request: Request) async throws -> Data {
        performImageRequestCalls.append(request)
        
        if let performImageRequestStub = performImageRequestStub {
            return performImageRequestStub
        } else {
            throw MockError.instance
        }
    }
}
