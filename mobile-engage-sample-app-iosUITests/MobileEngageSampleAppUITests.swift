//
//  Copyright (c) 2017 Emarsys. All rights reserved.
//

import XCTest
import Foundation

class MobileEngageSampleAppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app.launchEnvironment = ["applicationCode": "EMSEC-B103E",
                                 "applicationPassword": "RM1ZSuX8mgRBhQIgOsf6m8bn/bMQLAIb"]
        app.activate()
    }

    func testAnonymAppLogin() {
        eventuallyAssertSuccess {
            app.buttons["anonymousLogin"].tap()
        }
    }

    func testLogin() {
        let contactFieldIdTextField = app.textFields["contactFieldId"]
        let contactFieldValueTextField = app.textFields["contactFieldValue"]

        contactFieldIdTextField.tap()
        contactFieldIdTextField.typeText("123456789")

        contactFieldValueTextField.tap()
        contactFieldValueTextField.typeText("contactFieldValue")

        eventuallyAssertSuccess {
            app.buttons["login"].tap()
        }
    }

    func testTrackCustomEvent() {
        let customeventnameTextField = app.textFields["customEventName"]
        customeventnameTextField.tap()
        customeventnameTextField.typeText("customEventName")

        eventuallyAssertSuccess {
            app.buttons["trackCustomEvent"].tap()
        }
    }

    func testIAM() {
        let contactFieldIdTextField = app.textFields["contactFieldId"]
        let contactFieldValueTextField = app.textFields["contactFieldValue"]

        contactFieldIdTextField.tap()
        contactFieldIdTextField.typeText("3")

        contactFieldValueTextField.tap()
        contactFieldValueTextField.typeText("test@test.com")

        let customeventnameTextField = app.textFields["customEventName"]

        let okButton = app.alerts.buttons["OK"]
        let okButtonPredicate = NSPredicate(format: "exists == true")
        expectation(for: okButtonPredicate, evaluatedWith: okButton, handler: nil)

        app.buttons["login"].tap()

        waitForExpectations(timeout: 30, handler: nil)

        customeventnameTextField.tap()
        customeventnameTextField.typeText("Test")

        let closeButton = app.buttons["Close"]
        let closeButtonPredicate = NSPredicate(format: "exists == true")
        expectation(for: closeButtonPredicate, evaluatedWith: closeButton, handler: nil)

        app.buttons["trackCustomEvent"].tap()

        waitForExpectations(timeout: 30, handler: nil)
        XCUIApplication().terminate()
    }

    func testTrackMessageOpen() {
        let sidTextField = app.textFields["sid"]

        sidTextField.tap()
        sidTextField.typeText("dd8_zXfDdndBNEQi")

        eventuallyAssertSuccess {
            app.buttons["trackMessageOpen"].tap()
        }
    }

    func testAppLogout() {
        eventuallyAssertSuccess {
            app.buttons["logout"].tap()
        }
    }

    func eventuallyAssertSuccess(action: () -> ()) {
        let okButton = app.alerts.buttons["OK"]
        let predicate = NSPredicate(format: "exists == true")
        expectation(for: predicate, evaluatedWith: okButton, handler: nil)

        action()

        waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(okButton.exists)
        XCTAssert(app.alerts.element.label.lowercased().contains("success"))
    }

}
