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
        
        let signUoButton = app.buttons["SignUpButton"]
        signUoButton.tap()
        
        XCTAssertFalse(app.staticTexts["SignedInText"].exists)
    }
    
    func test_UITestingBootcampView_signUpButton_shouldSignIn() {
        let addTextTextField = app.textFields["SignUpTextField"]
        addTextTextField.tap()
        
        let gKey = app.keys["G"]
        gKey.tap()
        
        let signUoButton = app.buttons["SignUpButton"]
        signUoButton.tap()
        
        let signedInText = app.staticTexts["SignedInText"]
        
        XCTAssertTrue(signedInText.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayAlert() {
        let addTextTextField = app.textFields["SignUpTextField"]
        addTextTextField.tap()
        
        let gKey = app.keys["G"]
        gKey.tap()
        
        let signUoButton = app.buttons["SignUpButton"]
        signUoButton.tap()
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    func test_SignedInHomeView_showAlertButton_shouldDisplayandDismissAlert() {
        let addTextTextField = app.textFields["SignUpTextField"]
        addTextTextField.tap()
        
        let gKey = app.keys["G"]
        gKey.tap()
        
        let signUoButton = app.buttons["SignUpButton"]
        signUoButton.tap()
        
        let showAlertButton = app.buttons["ShowAlertButton"]
        showAlertButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        
        let alertOkButton = alert.buttons["OK"]
        alertOkButton.tap()
        
        let alertOkButtonExists = alertOkButton.waitForExistence(timeout: 5)
        XCTAssertTrue(alertOkButtonExists)
        
        let alertExists = alert.waitForExistence(timeout: 5)
        XCTAssertFalse(alertExists)
        
        XCTAssertFalse(alert.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestination() {
        let addTextTextField = app.textFields["SignUpTextField"]
        addTextTextField.tap()
        
        let gKey = app.keys["G"]
        gKey.tap()
        
        let signUoButton = app.buttons["SignUpButton"]
        signUoButton.tap()
        
        let navLink = app.buttons["NavigationLinkToDestination"]
        navLink.tap()
        
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
    }
    
    func test_SignedInHomeView_navigationLinkToDestination_shouldNavigateToDestinationAndGoBack() {
        let addTextTextField = app.textFields["SignUpTextField"]
        addTextTextField.tap()
        
        let gKey = app.keys["G"]
        gKey.tap()
        
        let signUoButton = app.buttons["SignUpButton"]
        signUoButton.tap()
        
        let navLink = app.buttons["NavigationLinkToDestination"]
        navLink.tap()
        
        let destinationText = app.staticTexts["Destination"]
        XCTAssertTrue(destinationText.exists)
        
        let navBackButton = app.navigationBars.buttons["Back"]
        navBackButton.tap()
        
        let signedInText = app.staticTexts["SignedInText"]
        XCTAssertTrue(signedInText.exists)
    }
}
