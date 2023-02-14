//
//  DirectoryRequestTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class DirectoryRequestTests: XCTestCase {

    private let directory = Directory.fake()
    private var sut: DirectoryRequest!
    
    override func setUp() {
        super.setUp()
        sut = DirectoryRequest(directory: directory)
    }
    
    override func tearDown()  {
        sut = nil
        super.tearDown()
    }
    
    func test_Endpoint_ReturnsCorrectValue() {
        XCTAssertEqual(sut.endpoint, .items(directory))
    }
    
    func test_Method_ReturnsCorrectValue() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func test_Headers_ReturnsCorrectValue() {
        XCTAssertEqual(sut.headers, [:])
    }
    
    func test_ResponseContainsFractionalDate_ReturnsCorrectValue() {
        XCTAssertTrue(sut.responseContainsFractionalDate)
    }
}
