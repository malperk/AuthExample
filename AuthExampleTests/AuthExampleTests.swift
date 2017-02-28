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
        basicAuth(username: "user", password: "passwd") { resp in
            XCTAssertNotNil(resp)
            XCTAssertNotNil(resp.response)
            XCTAssertEqual(resp.response?.statusCode, 200)
            XCTAssertNotNil(resp.data)
            if let unwrappedData = resp.data {
                let json = try? getJson(data: unwrappedData)
                XCTAssertNotNil(json)
                if let unwrappedJson = json {
                    let authenticated = unwrappedJson["authenticated"] as! Bool
                    XCTAssert(authenticated)
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }

    func testBasicAuthenticationFail() {
        let expectation = self.expectation(description: "Basic Authentication request should fail")
        basicAuth(username: "user", password: "wrong") { resp in
            XCTAssertNotNil(resp)
            XCTAssertNotNil(resp.response)
            XCTAssertEqual(resp.response?.statusCode, 401)
            expectation.fulfill()
        }
        waitForExpectations(timeout: timeout, handler: nil)
    }
    func testSystemBasicAuthentication() {
        let expectation = self.expectation(description: "Basic Authentication request should succeed")
        let basicAuth = Auth.init()
        basicAuth.auth(urlString: "https://httpbin.org/basic-auth/user/passwd", username: "user", password: "passwd") { resp in
            XCTAssertNotNil(resp)
            XCTAssertNotNil(resp.response)
            XCTAssertEqual(resp.response?.statusCode, 200)
            XCTAssertNotNil(resp.data)
            if let unwrappedData = resp.data {
                let json = try? getJson(data: unwrappedData)
                XCTAssertNotNil(json)
                if let unwrappedJson = json {
                    let authenticated = unwrappedJson["authenticated"] as! Bool
                    XCTAssert(authenticated)
                }
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testSystemDigestAuthentication() {
        let expectation = self.expectation(description: "Basic Authentication request should succeed")
        let basicAuth = Auth.init()
        basicAuth.auth(urlString: "https://httpbin.org/digest-auth/auth/user/passwd", username: "user", password: "passwd") { resp in
            XCTAssertNotNil(resp)
            XCTAssertNotNil(resp.response)
            XCTAssertEqual(resp.response?.statusCode, 200)
            XCTAssertNotNil(resp.data)
            if let unwrappedData = resp.data {
                let json = try? getJson(data: unwrappedData)
                XCTAssertNotNil(json)
                if let unwrappedJson = json {
                    let authenticated = unwrappedJson["authenticated"] as! Bool
                    XCTAssert(authenticated)
                }
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
}

// https://httpbin.org/digest-auth/auth/user/passwd
