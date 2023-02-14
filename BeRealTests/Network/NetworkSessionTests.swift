//
//  NetworkSessionTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class NetworkSessionTests: XCTestCase {

    private var sut: NetworkSession!
    private var mockNetworkProvider: MockURLSessionProvider!
    
    override func setUp() {
        super.setUp()
        mockNetworkProvider = MockURLSessionProvider()
        sut = NetworkSession(host: "www.test.com", sessionProvider: mockNetworkProvider)
    }
    
    override func tearDown()  {
        sut = nil
        mockNetworkProvider = nil
        super.tearDown()
    }
    
    func test_PerformRequest_URLRequestNil_ThrowsBadRequestError() async throws {
        let request = MockRequest()
        sut = NetworkSession(host: "", sessionProvider: mockNetworkProvider)
        
        do {
            _ = try await sut.performRequest(request, type: MockModel.self)
            XCTFail("Shouldn't get this far")
        } catch let error {
            
            let networkError = error as? NetworkError
            XCTAssertEqual(networkError, .badRequest(request))
        }
    }
    
    func test_PerformRequest_ResponseNotSuccessful_ThrowsBadResponseError() async throws {
        let data = try makeData(from: "")
        let response = try makeHTTPURLResponse(with: 401)
        mockNetworkProvider.dataStub = (data, response)

        do {
            let request = MockRequest()
            _ = try await sut.performRequest(request, type: MockModel.self)
            XCTFail("Shouldn't get this far")
        } catch let error {
            let networkError = error as? NetworkError
            XCTAssertEqual(networkError, .badResponse(data, response))
        }
    }
    
    func test_PerformRequest_UseFractionalSecondsTrue_ReturnsCorrectValue() async throws {
        var request = MockRequest()
        request.responseContainsFractionalDate = true
        let data = try makeData(from: "{\"date\": \"2000-01-01T12:12:12.0000000Z\"}")
        let response = try makeHTTPURLResponse(with: 200)
        mockNetworkProvider.dataStub = (data, response)

        do {
            let model = try await sut.performRequest(request, type: MockModel.self)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssssssZ"
            let date = dateFormatter.string(from: model.date)
            XCTAssertEqual(date, "2000-01-01T12:12:12.0000012+0000")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_PerformRequest_UseFractionalSecondsFalse_ReturnsCorrectValue() async throws {
        let request = MockRequest()
        let data = try makeData(from: "{\"date\": \"2000-01-01T12:12:12Z\"}")
        let response = try makeHTTPURLResponse(with: 200)
        mockNetworkProvider.dataStub = (data, response)

        do {
            let model = try await sut.performRequest(request, type: MockModel.self)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.string(from: model.date)
            XCTAssertEqual(date, "2000-01-01T12:12:12+0000")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }

    private func makeData(from string: String) throws -> Data {
        try XCTUnwrap(string.data(using: .utf8))
    }
    
    private func makeHTTPURLResponse(with statusCode: Int) throws -> HTTPURLResponse {
        let url = try XCTUnwrap(URL(string: "www.test.com"))
        return try XCTUnwrap(
            HTTPURLResponse(
                url: url,
                statusCode: statusCode,
                httpVersion: "1",
                headerFields: [:]
            )
        )
    }
}

