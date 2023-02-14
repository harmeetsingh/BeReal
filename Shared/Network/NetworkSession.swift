//
//  NetworkSession.swift
//  BeReal
//
//  Created by Harmeet Singh on 14/02/2023.
//

import Foundation

protocol NetworkSessionType {
 
    func performRequest<Model: Decodable>(_ request: Request, type: Model.Type) async throws -> Model
    func performImageRequest(_ request: Request) async throws -> Data
}

final class NetworkSession: NetworkSessionType {
    
    private let host: String
    private let sessionProvider: URLSessionProviding
    private var credentials: UserCredentials?
    
    init(host: String, sessionProvider: URLSessionProviding) {
        self.host = host
        self.sessionProvider = sessionProvider
    }

    func performRequest<Model: Decodable>(_ request: Request, type: Model.Type) async throws -> Model {
        let data = try await executeRequest(request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            try self.decodeDate(with: decoder, useFactionalSeconds: request.responseContainsFractionalDate)
        }
        
        let model = try decoder.decode(type.self, from: data)
        return model
    }
    
    func performImageRequest(_ request: Request) async throws -> Data {
        try await executeRequest(request)
    }
    
    @MainActor // TODO: Remove @MainActor and find a way to return on main thread
    private func executeRequest(_ request: Request) async throws -> Data {
        
        guard let urlRequest = request.makeRequest(with: host, credentials: credentials) else {
            throw NetworkError.badRequest(request)
        }
        
        let (data, response) = try await sessionProvider.data(for: urlRequest)
        
        guard response.isSuccessful, !data.isEmpty else {
            throw NetworkError.badResponse(data, response)
        }
        
        if let userRequest = request as? UserRequest {
            credentials = userRequest.userCredentials
        }
        
        return data
    }
    
    private func decodeDate(with decoder: Decoder, useFactionalSeconds: Bool) throws -> Date {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        let formatter = ISO8601DateFormatter()
        
        if useFactionalSeconds {
            formatter.formatOptions.insert(.withFractionalSeconds)
            formatter.formatOptions = [
                .withInternetDateTime,
                .withFractionalSeconds
            ]
        }
        
        if let date = formatter.date(from: dateString) {
            return date
        } else {
            // TODO: Add localisation and avoid hardcoded strings!
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        }
    }
}
