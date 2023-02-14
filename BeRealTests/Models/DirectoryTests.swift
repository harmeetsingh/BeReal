//
//  DirectoryTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal

final class DirectoryTests: XCTestCase {
    
    private var sut: Directory!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = try makeSUT(isDir: true)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func makeSUT(isDir: Bool) throws -> Directory {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = try XCTUnwrap(dateFormatter.date(from: "2000-01-01T12:12:12"))
        return Directory(
            id: "1",
            parentId: "2",
            name: "name",
            isDir: isDir,
            modificationDate: date
        )
    }
    
    func test_FromattedDate_ReturnsCorrectValue() {
        XCTAssertEqual(sut.formattedDate, "2000-01-01T12:12")
    }
    
    func test_SystemImageName_IsDirTrue_ReturnsCorrectValue() {
        XCTAssertEqual(sut.systemImageName, "folder")
    }
    
    func test_SystemImageName_IsDirFalse_ReturnsCorrectValue() throws {
        sut = try makeSUT(isDir: false)
        XCTAssertEqual(sut.systemImageName, "photo")
    }
}
