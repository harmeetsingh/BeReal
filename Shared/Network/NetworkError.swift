//
//  NetworkError.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

enum NetworkError: Error, Equatable{

    case badRequest(Request)
    case badResponse(Data, URLResponse)
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case let (.badRequest(lhsRequest), .badRequest(rhsRequest)):
            return lhsRequest.endpoint == rhsRequest.endpoint &&
            lhsRequest.method == rhsRequest.method &&
            lhsRequest.headers == rhsRequest.headers &&
            lhsRequest.responseContainsFractionalDate == rhsRequest.responseContainsFractionalDate
        case let (.badResponse(lhsData, lhsResponse), .badResponse(rhsData, rhsResponse)):
            return lhsData == rhsData && lhsResponse == rhsResponse
        default:
            return false
        }
    }
}
