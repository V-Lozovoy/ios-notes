//  SimpleNotesUITests.swift
//  SimpleNotesUITests

import XCTest

final class SimpleNotesUITests: XCTestCase {

    override func setUpWithError() throws {
        
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}

