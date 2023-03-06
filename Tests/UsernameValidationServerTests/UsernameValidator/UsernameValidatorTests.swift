//
//  UsernameValidatorTests.swift
//  
//
//  Created by Chris Williamson on 06/03/2023.
//

import XCTest
@testable import UsernameValidationServer

final class UsernameValidatorTests: XCTestCase {

    func testValidate_givenUsernameOfLength3_throwsTooShortError() throws {
        let validator = UsernameValidator()
        XCTAssertThrowsError(try validator.validate("cjw")) {
            XCTAssertEqual($0 as? UsernameValidationError, UsernameValidationError.tooShort)
        }
    }

    func testValidate_givenUsernameOfLength21_throwsTooLongError() throws {
        let validator = UsernameValidator()
        XCTAssertThrowsError(try validator.validate("cjw cjw cjw cjw cjw !")) {
            XCTAssertEqual($0 as? UsernameValidationError, UsernameValidationError.tooLong)
        }
    }
}
