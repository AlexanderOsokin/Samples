//
//  SearchTestTests.swift
//  SearchTestTests
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import XCTest
@testable import SearchTest

class JsonParseTests: XCTestCase {
    
    var httpClient: HttpClient!
    var expectation: XCTestExpectation!
    var gitSearchSource: GitSearchSource!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.httpClient = HttpClient()
        self.gitSearchSource = GitSearchSource(httpClient: self.httpClient)
        self.gitSearchSource.delegate = self
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        httpClient = nil
    }
    
    func testGitQuery() {
        self.measure {
            expectation = XCTestExpectation(description: "test git query")
            gitSearchSource.search(query: "ronin")
            wait(for: [expectation], timeout: 20)
        }
    }
    
    func testItunesQuery() {
        self.measure {
            expectation = XCTestExpectation(description: "test itunes query")
            httpClient.request(endpoint: .itunes, query: "Star Wars")
            wait(for: [expectation], timeout: 20)
        }
    }
}

extension JsonParseTests: SearchSourceDelegate {
    func searchComplete() {
        XCTAssert(gitSearchSource.itemsCount > 0)
        expectation.fulfill()
    }
}

