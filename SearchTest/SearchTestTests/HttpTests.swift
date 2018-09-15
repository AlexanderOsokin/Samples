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
        self.httpClient.delegate = self
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        httpClient = nil
    }
    
    func testGitQuery() {
            expectation = XCTestExpectation(description: "test git query")
            httpClient.request(endpoint: .github, query: "ronin")
            wait(for: [expectation], timeout: 20)
    }
    
    func testItunesQuery() {
            expectation = XCTestExpectation(description: "test itunes query")
            httpClient.request(endpoint: .itunes, query: "Star Wars")
            wait(for: [expectation], timeout: 20)
    }
}

extension HttpTests: HttpClientDelegate {
    func requestCompleteWithError(_ data: Data?, _ errorDescription: String?) {
        XCTAssertNotNil(data)
        XCTAssertNil(errorDescription)
        expectation.fulfill()
    }
}
