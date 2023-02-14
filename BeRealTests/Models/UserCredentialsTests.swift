//
//  UserCredentialsTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class UserCredentialsTests: XCTestCase {
    
    private var sut: UserCredentials!
    
    override func setUp() {
        super.setUp()
        sut = UserCredentials.fake()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func test_EncodedCredentials_ReturnsCorrectValue() {
        XCTAssertEqual(sut.encodedCredentials, "aGVsbG86d29ybGQ=")
    }
}
