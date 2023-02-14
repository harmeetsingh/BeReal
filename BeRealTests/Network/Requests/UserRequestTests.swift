//
//  UserRequestTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class UserRequestTests: XCTestCase {

    private var sut: Request!
    
    override func setUp() {
        super.setUp()
        let credentials = UserCredentials.fake()
        sut = UserRequest(userCredentials: credentials)
    }
    
    override func tearDown()  {
        sut = nil
        super.tearDown()
    }
    
    func test_Endpoint_ReturnsCorrectValue() {
        XCTAssertEqual(sut.endpoint, .me)
    }
    
    func test_Method_ReturnsCorrectValue() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func test_Headers_ReturnsCorrectValue() {
        XCTAssertEqual(sut.headers, ["Authorization": "Basic aGVsbG86d29ybGQ="])
    }
}
