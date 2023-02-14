//
//  RespositoryTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

@testable import BeReal
import XCTest

final class RepositoryTests: XCTestCase {
    
    private var sut: Repository!
    private var mockNetworkSession: MockNetworkSession!
    
    override func setUp() {
        super.setUp()
        mockNetworkSession = MockNetworkSession()
        sut = Repository(networkSession: mockNetworkSession)
    }
    
    override func tearDown() {
        mockNetworkSession = nil
        sut = nil
        super.tearDown()
    }
    
    // MARK: - fetchUser
    
    func test_FetchUser_NetworkSessionCalledCorrectly() async {
        let credentials = UserCredentials.fake()
        _ = try? await sut.fetchUser(with: credentials)

        XCTAssertEqual(mockNetworkSession.performRequestCalls.count, 1)

        let expectedRequest = UserRequest(userCredentials: credentials)
        let actualRequest = mockNetworkSession.performRequestCalls.first?.0 as? UserRequest
        XCTAssertEqual(actualRequest, expectedRequest)
    }
    
    func test_FetchUser_ReturnsCorrectValue() async throws {
        let user = User.fake()
        mockNetworkSession.performRequestStub = user
        
        let credentials = UserCredentials.fake()
        let model = try await sut.fetchUser(with: credentials)
        XCTAssertEqual(model, user)
    }
    
    // MARK: - fetchSubDirectories
    
    func test_FetchSubDirectories_NetworkSessionCalledCorrectly() async {
        let directory = Directory.fake()
        _ = try? await sut.fetchSubDirectories(in: directory)

        XCTAssertEqual(mockNetworkSession.performRequestCalls.count, 1)

        let expectedRequest = DirectoryRequest(directory: directory)
        let actualRequest = mockNetworkSession.performRequestCalls.first?.0 as? DirectoryRequest
        XCTAssertEqual(actualRequest, expectedRequest)
    }
    
    func test_FetchSubDirectories_ReturnsCorrectValue() async throws {
        let directory = Directory.fake()
        mockNetworkSession.performRequestStub = [directory]
        let model = try await sut.fetchSubDirectories(in: directory)
        XCTAssertEqual(model, [directory])
    }
    
    // MARK: - fetchImage
    
    func test_FetchImage_NetworkSessionCalledCorrectly() async {
        let directory = Directory.fake()
        _ = try? await sut.fetchImage(in: directory)
        XCTAssertEqual(mockNetworkSession.performImageRequestCalls.count, 1)

        let expectedRequest = ImageRequest(directory: directory)
        let actualRequest = mockNetworkSession.performImageRequestCalls.first as? ImageRequest
        XCTAssertEqual(actualRequest, expectedRequest)
    }
    
    func test_FetchImage_ReturnsCorrectValue() async throws {
        let directory = Directory.fake()
        let expectedValue = "Hello".data(using: .utf8)
        mockNetworkSession.performImageRequestStub = expectedValue
        let model = try await sut.fetchImage(in: directory)
        XCTAssertEqual(model, expectedValue)
    }
}
