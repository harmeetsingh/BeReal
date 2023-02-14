//
//  LoginViewModelTests.swift
//  BeRealTests
//
//  Created by Harmeet Singh on 14/02/2023.
//

import XCTest
@testable import BeReal
import Combine

final class LoginViewModelTests: XCTestCase {
    
    private var sut: LoginViewModel!
    private var mockRepository: MockUserRepository!
    private var mockDelegate: MockLoginViewModelDelegate!
    private var cancellable: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        mockDelegate = MockLoginViewModelDelegate()
        cancellable = Set<AnyCancellable>()
        sut = LoginViewModel(repository: mockRepository, delegate: mockDelegate)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        mockDelegate = nil
        cancellable = nil
        super.tearDown()
    }
    
    // MARK: - login
    
    func test_Login_FetchUserFails_ViewStateCorrectValue() async {
        let expectation = self.expectation(description: #function)
        var viewStates = [LoginViewState]()
        sut.$viewState
            .sink {
                viewStates.append($0)
                if viewStates.count == 3 { // TODO: use withCheckedThrowingContinuation to force the closure to run and remove the viewStates count
                    XCTAssertEqual(viewStates, [.idle, .loading, .failed(MockError.instance)])
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)

        await sut.login()
        await waitForExpectations(timeout: 0.1)
    }
    
    func test_Login_FetchUserFails_IsAlertPresentedCorrectValue() async {
        await sut.login()
        XCTAssertEqual(sut.isAlertPresented, true)
    }

    func test_Login_FetchUserSucceeeds_ViewStateCorrectValue() async {
        mockRepository.fetchUserStub = User.fake()
        let expectation = self.expectation(description: #function)
        var viewStates = [LoginViewState]()
        sut.$viewState
            .sink {
                viewStates.append($0)
                if viewStates.count == 3 {
                    XCTAssertEqual(viewStates, [.idle, .loading, .loaded])
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        await sut.login()
        await waitForExpectations(timeout: 0.1)
    }
    
    // MARK: - dismissAlert
    
    func test_DissmissAlert_ViewStateCorrectValue() {
        sut.dismissAlert()
        XCTAssertEqual(sut.viewState, .idle)
    }
    
    func test_DissmissAlert_IsAlertPresentedCorrectValue() {
        sut.dismissAlert()
        XCTAssertEqual(sut.isAlertPresented, false)
    }
}
