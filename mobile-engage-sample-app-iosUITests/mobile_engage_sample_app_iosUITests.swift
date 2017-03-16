//
//  mobile_engage_sample_app_iosUITests.swift
//  mobile-engage-sample-app-iosUITests
//
//  Created by Laszlo Ori on 2017. 03. 14..
//  Copyright (c) 2017 Emarsys. All rights reserved.
//

import XCTest

class mobile_engage_sample_app_iosUITests: XCTestCase {
    
    let app = XCUIApplication()
    
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
    
    func testAnonymAppLogin() {
        let okButton = app.alerts.buttons["OK"]
        
        let predicate = NSPredicate(format: "exists == true")
        expectation(for: predicate, evaluatedWith: okButton, handler: nil)
        
        app.buttons["anonymousLogin"].tap()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(okButton.exists)
    }
    
}
