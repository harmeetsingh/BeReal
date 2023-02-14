//
//  RequestTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class RequestTests: XCTestCase {

    private var sut: Request!
    
    override func setUp() {
        super.setUp()
        sut = MockRequest()
    }
    
    override func tearDown()  {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - responseContainsFractionalDate
    
    func test_ResponseContainsFractionalDate_ReturnsCorrectValue() {
        XCTAssertFalse(sut.responseContainsFractionalDate)
    }
    
    func test_makeRequest_ReturnsCorrectValue() {
        let credentials = UserCredentials.fake()
        let urlRequest = sut.makeRequest(with: "www.test.com", credentials: credentials)
        
        // TODO: Move these asserts into individual test functions
        // I've grouped them for now to speed things up
        XCTAssertEqual(urlRequest?.url?.path, "www.test.com/me")
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields, ["Authorization": "Basic aGVsbG86d29ybGQ="])
    }
}
