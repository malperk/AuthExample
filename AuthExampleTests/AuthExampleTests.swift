//
//  AuthExampleTests.swift
//  AuthExampleTests
//
//  Created by Alper KARATAŞ on 27/02/2017.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import XCTest
@testable import AuthExample

let timeout = TimeInterval(10)

class AuthExampleTests: XCTestCase {
    func testBasicAuthentication() {
        let expectation = self.expectation(description: "Basic Authentication request should succeed")
        basicAuth(username: "user", password: "passwd") { (resp) in
            XCTAssertEqual(resp.response?.statusCode, 200)
            XCTAssertNotNil(resp.data)
            let json = try? getJson(data: resp.data!)
            XCTAssertNotNil(json)
            let authenticated = json?["authenticated"] as! Bool
            XCTAssert(authenticated)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
}



//basicAuth(username: "user", password: "passwd")
