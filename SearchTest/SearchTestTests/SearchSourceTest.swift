//
//  SearchTestTests.swift
//  SearchTestTests
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import XCTest
@testable import SearchTest

class SearchSourceParseTests: XCTestCase {
    
    var httpClient: HttpClient!
    var expectation: XCTestExpectation!
    var gitSearchSource: GitSearchSource!
	var itunesSearchSource: ItunesSearchSource!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

		self.gitSearchSource = GitSearchSource(httpClient: HttpClient())
		self.itunesSearchSource = ItunesSearchSource(httpClient: HttpClient())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
		gitSearchSource = nil
		itunesSearchSource = nil
    }
    
    func testGitQuery() {
		expectation = XCTestExpectation(description: "test git query")
			gitSearchSource.search(query: "jack") { results, description in
				XCTAssertNotNil(results)
				XCTAssertNil(description)

				let result = results[0]
				let gitViewModel = result as! GitItemViewModel
				let gitModel = gitViewModel.model

				XCTAssertNotNil(gitModel.image)
				XCTAssertNotNil(gitModel.login)
				XCTAssertNotNil(gitModel.url)

				self.expectation.fulfill()
			}
            wait(for: [expectation], timeout: 20)
    }
    
    func testItunesQuery() {

            expectation = XCTestExpectation(description: "test itunes query")
			itunesSearchSource.search(query: "Star Wars") { results, description in
				XCTAssertNotNil(results)
				XCTAssertNil(description)

				let result = results[0]
				let itunesViewModel = result as! ItunesItemViewModel
				let itunesModel = itunesViewModel.model

				XCTAssertNotNil(itunesModel.image)
				XCTAssertNotNil(itunesModel.title)
				XCTAssertNotNil(itunesModel.author)

				self.expectation.fulfill()
				
			}
            wait(for: [expectation], timeout: 20)
        }
}
