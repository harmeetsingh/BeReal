//
//  EndpointsTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class EndpointsTests: XCTestCase {
    
    func test_Path_CaseIsMe_ReturnsCorrectValue() {
        XCTAssertEqual(Endpoints.me.path, "/me")
    }
    
    func test_Path_CaseIsItems_ReturnsCorrectValue() {
        let directory = Directory.fake()
        XCTAssertEqual(Endpoints.items(directory).path, "/items/1")
    }
    
    func test_Path_CaseIsDownload_ReturnsCorrectValue() {
        let directory = Directory.fake()
        XCTAssertEqual(Endpoints.download(directory).path, "/items/1/data")
    }
}
