//
//  SearchTestTests.swift
//  SearchTestTests
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import XCTest
@testable import SearchTest

class HttpTests: XCTestCase {
    
    var httpClient: HttpClient!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.httpClient = HttpClient()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        httpClient = nil
    }
    
    func testGitQuery() {
            expectation = XCTestExpectation(description: "test git query")
			httpClient.searchRequest(endpoint: .github, query: "james") { [unowned self] data, description in
			XCTAssertNotNil(data)
			XCTAssertNil(description)
			self.expectation.fulfill()
		}
            wait(for: [expectation], timeout: 20)
    }
    
    func testItunesQuery() {
		expectation = XCTestExpectation(description: "test itunes query")
		httpClient.searchRequest(endpoint: .github, query: "frank") { [unowned self] data, description in
			XCTAssertNotNil(data)
			XCTAssertNil(description)
			self.expectation.fulfill()
		}
		wait(for: [expectation], timeout: 20)
    }
}
