//
//  SearchTestUITests.swift
//  SearchTestUITests
//
//  Created by Edu user on 05/09/2018.
//  Copyright © 2018 Alexander Osokin. All rights reserved.
//

import XCTest

class SearchTestUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    


    func testExample() {
		let app = XCUIApplication()
		let searchSearchField = app.searchFields["Search"]
		searchSearchField.tap()
		searchSearchField.typeText("star wars")

		sleep(2)

		let tablesQuery = app.tables
		tablesQuery.cells.element(boundBy: 2).children(matching: .image).element.tap()

		sleep(1)

		let image = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .image).element

		image.tap()
		let cancelButton = app.buttons["Cancel"]
		cancelButton.tap()
		app.navigationBars["SearchTest.MainView"]/*@START_MENU_TOKEN@*/.buttons["GitHub"]/*[[".staticTexts.buttons[\"GitHub\"]",".buttons[\"GitHub\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
		searchSearchField.tap()
		searchSearchField.typeText("jack london")

		sleep(10)

		tablesQuery.cells.element(boundBy: 3).children(matching: .image).element.tap()

		sleep(1)

		image.tap()

		cancelButton.tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
