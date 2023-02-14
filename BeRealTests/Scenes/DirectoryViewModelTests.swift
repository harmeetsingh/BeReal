//
//  DirectoryViewModelTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal
import Combine

final class DirectoryViewModelTests: XCTestCase {
    
    private var sut: DirectoryViewModel!
    private var mockRepository: MockDirectoryRepository!
    private var mockDelegate: MockDirectoryViewModelDelegate!
    private var cancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockDirectoryRepository()
        mockDelegate = MockDirectoryViewModelDelegate()
        cancellable = Set<AnyCancellable>()
        sut = DirectoryViewModel(directory: .fake(), repository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        mockDelegate = nil
        cancellable = nil
        super.tearDown()
    }

    // MARK: - onAppear

    func test_InAppear_FetchSubDirectoriesFails_ViewStateCorrectValue() async {
        let expectation = self.expectation(description: #function)
        var viewStates = [DirectoryViewState]()
        sut.$viewState
            .sink {
                viewStates.append($0)
                if viewStates.count == 2 { // TODO: use withCheckedThrowingContinuation to force the closure to run and remove the viewStates count
                    XCTAssertEqual(viewStates, [.loading, .failed(MockError.instance)])
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)

        await sut.onAppear()
        await waitForExpectations(timeout: 0.1)
    }
    
    func test_InAppear_FetchSubDirectoriesFails_IsAlertPresentedCorrectValue() async {
        await sut.onAppear()
        XCTAssertEqual(sut.isAlertPresented, true)
    }

    func test_InAppear_FetchSubDirectoriesSucceeedsWithEmptyArray_ViewStateCorrectValue() async {
        mockRepository.fetchSubDirectoriesStub = []
        let expectation = self.expectation(description: #function)
        var viewStates = [DirectoryViewState]()
        sut.$viewState
            .sink {
                viewStates.append($0)
                if viewStates.count == 2 {
                    XCTAssertEqual(viewStates, [.loading, .empty])
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        await sut.onAppear()
        await waitForExpectations(timeout: 0.1)
    }
    
    func test_InAppear_FetchSubDirectoriesSucceeedsWithNonEmptyArray_ViewStateCorrectValue() async {
        mockRepository.fetchSubDirectoriesStub = [.fake()]
        let expectation = self.expectation(description: #function)
        var viewStates = [DirectoryViewState]()
        sut.$viewState
            .sink {
                viewStates.append($0)
                if viewStates.count == 2 {
                    XCTAssertEqual(viewStates, [.loading, .loaded])
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        await sut.onAppear()
        await waitForExpectations(timeout: 0.1)
    }
    
    // MARK: - dismissAlert
    
    func test_DissmissAlert_ViewStateCorrectValue() {
        sut.dismissAlert()
        XCTAssertEqual(sut.viewState, .loaded)
    }
    
    func test_DissmissAlert_IsAlertPresentedCorrectValue() {
        sut.dismissAlert()
        XCTAssertEqual(sut.isAlertPresented, false)
    }
}

