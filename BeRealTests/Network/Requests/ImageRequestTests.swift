//
//  ImageRequestTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class ImageRequestTests: XCTestCase {

    private let directory = Directory.fake()
    private var sut: ImageRequest!
    
    override func setUp() {
        super.setUp()
        sut = ImageRequest(directory: directory)
    }
    
    override func tearDown()  {
        sut = nil
        super.tearDown()
    }
    
    func test_Endpoint_ReturnsCorrectValue() {
        XCTAssertEqual(sut.endpoint, .download(directory))
    }
    
    func test_Method_ReturnsCorrectValue() {
        XCTAssertEqual(sut.method, .get)
    }
    
    func test_Headers_ReturnsCorrectValue() {
        XCTAssertEqual(sut.headers, [:])
    }
}
