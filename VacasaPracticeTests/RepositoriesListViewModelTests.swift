//
//  VacasaPracticeTests.swift
//  VacasaPracticeTests
//
//  Created by Tony Mu on 23/12/21.
//

import XCTest
@testable import VacasaPractice

class RepositoriesListViewModelTests: XCTestCase {

    let timeout: TimeInterval = 5
    var testExpectation: XCTestExpectation?
    
    override func setUp() {
        testExpectation = self.expectation(description: "CallBack")
    }
    
    func testLoadDataSuccess() throws {
        
        // Arrange
        let mockWebService = MockWebServcie(expectedResult: .success(RepositorySearchResultDto(totalCount: 1, isIncompleted: false, items: [RepositoryDto(name: "Repo1", description: "description")])))
        let view = MockListViewController(testExpection: testExpectation!)
        let viewModel = RepositoriesListViewModel(repositoryWebServcie: mockWebService)
        viewModel.delegate = view
        
        // Act
        viewModel.loadList()
        
        // Assert
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertTrue(view.isDataLoaded)
        XCTAssertNil(view.errorMessage)
        XCTAssertEqual(viewModel.items[0].name, "Repo1")
        XCTAssertEqual(viewModel.items[0].description, "description")
    }
    
    func testLoadDataFailed() throws {
        
        // Arrange
        let mockWebService = MockWebServcie(expectedResult: .failure(.notFound))
        let view = MockListViewController(testExpection: testExpectation!)
        let viewModel = RepositoriesListViewModel(repositoryWebServcie: mockWebService)
        viewModel.delegate = view
        
        // Act
        viewModel.loadList()
        
        // Assert
        waitForExpectations(timeout: timeout, handler: nil)
        XCTAssertTrue(viewModel.items.isEmpty)
        XCTAssertFalse(view.isDataLoaded)
        XCTAssertEqual(view.errorMessage, "Sorry, we are unable to get the repositories, please try again later.")
    }
}


class MockWebServcie: RepositoryServiceProtocol {
    typealias RepositoryServiceMockResult = Result<RepositorySearchResultDto, ApiError>
    private let expectedResult: RepositoryServiceMockResult
    
    init(expectedResult: RepositoryServiceMockResult) {
        self.expectedResult = expectedResult
    }
    
    func fetch(completion: @escaping RepositoryServiceResult) {
        completion(expectedResult)
    }
    
    func fetch() async throws -> RepositorySearchResultDto {
        switch expectedResult {
        case .success(let result):
            return result
        case .failure(let error):
            throw error
        }
    }
}

class MockListViewController: RepositoriesListViewModelDelegate {
    private let testExpection: XCTestExpectation
    
    public private(set) var isDataLoaded: Bool = false
    public private(set) var errorMessage: String? = nil
    
    init(testExpection: XCTestExpectation) {
        self.testExpection = testExpection
    }
    
    func displayError(_ error: ListError) {
        errorMessage = error.localizedMessage
        testExpection.fulfill()
    }
    
    func didLoadData() {
        isDataLoaded = true
        testExpection.fulfill()
    }
}
