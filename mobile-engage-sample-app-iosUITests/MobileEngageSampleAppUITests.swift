//
//  Copyright (c) 2017 Emarsys. All rights reserved.
//

import XCTest

class MobileEngageSampleAppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
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

    func testTrackMessageOpen() {
        let sidTextField = app.textFields["sid"]

        sidTextField.tap()
        sidTextField.typeText("dd8_zXfDdndBNEQi")

        eventuallyAssertSuccess {
            app.buttons["trackMessageOpen"].tap()
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

        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(okButton.exists)
        XCTAssert(app.alerts.element.label.lowercased().contains("success"))
    }

}
