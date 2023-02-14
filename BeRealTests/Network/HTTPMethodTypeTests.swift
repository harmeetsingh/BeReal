//
//  HTTPMethodTypeTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class HTTPMethodTypeTests: XCTestCase {
    
    func test_GET_ReturnsCorrectValue() {
        XCTAssertEqual(HTTPMethodType.get.rawValue, "GET")
    }
}
