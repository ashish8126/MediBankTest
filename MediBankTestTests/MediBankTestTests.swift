//
//  MediBankTestTests.swift
//  MediBankTestTests
//
//  Created by Ashish Viltoriya on 25/10/23.
//

import XCTest
@testable import MediBankTest

final class MediBankTestTests: XCTestCase {

    func test_API_failure() {
        let viewModel = HeadingListViewModel()
        let mockService = MockHeadlinesService()
        mockService.result = .failure(.invalidData)
        viewModel.getDataFromServer()
        XCTAssert(viewModel.articleData.value.isEmpty)
        
    }
    
    func test_API_success() {
        let viewModel = HeadingListViewModel()
        let mockService = MockHeadlinesService()
        guard let articlesData = mockService.getArticles() else {
            return
        }
        let expectations = self.expectation(description: "Articles API call")
        mockService.result = .success(articlesData.articles)
        viewModel.getDataFromServer()
        wait(for: [expectations], timeout: 10)
        expectations.fulfill()
        XCTAssert(!viewModel.articleData.value.isEmpty)
    }

}
