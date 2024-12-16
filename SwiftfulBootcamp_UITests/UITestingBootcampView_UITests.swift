//
//  UITestingBootcampView_UITests.swift
//  SwiftfulBootcamp_UITests
//
//  Created by Akbarshah Jumanazarov on 12/16/24.
//

import XCTest

final class UITestingBootcampView_UITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                app.launch()
            }
        }
    }
    
    func test_UITestingBootcampView_signUpButton_shouldNotSignIn() {
        let addTextTextField = app.textFields["SignUpTextField"]
        addTextTextField.tap()
        app.buttons["Sign Up"].tap()
        XCTAssertFalse(app.staticTexts["Signed In!"].exists)
    }
    
    func test_UITestingBootcampView_signUpButton_shouldSignIn() {
        let addTextTextField = app.textFields["SignUpTextField"]
        addTextTextField.tap()
        let gKey = app/*@START_MENU_TOKEN@*/.keys["G"]/*[[".keyboards",".otherElements[\"UIKeyboardLayoutStar Preview\"].keys[\"G\"]",".keys[\"G\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        gKey.tap()
        app.buttons["Sign Up"].tap()
        XCTAssertTrue(app.staticTexts["Signed In!"].exists)
    }
}
