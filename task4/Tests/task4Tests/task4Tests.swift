import XCTest
@testable import task4

final class task4Tests: XCTestCase {
    func testInvalidLengthLogins() {
        let invalidLengthLogins = [
            "to",
            "some_large_email_address@and-domain.com"
        ]
        
        invalidLengthLogins.forEach {
            XCTAssertFalse(task4.isValidLogin($0))
        }
    }
    
    func testValidLogins() {
        let validLogins = [
            "tortik",
            "tort1k",
            "t.rt1k",
            "t.r-1k",
            "t..--.",
            "BigTortik",
        ]
        
        validLogins.forEach {
            XCTAssert(task4.isValidLogin($0))
        }
    }
    
    func testInvalidLogins() {
        let invalidLogins = [
            "1tortik",
            ".ortik",
            "-ortik"
        ]
        
        invalidLogins.forEach {
            XCTAssertFalse(task4.isValidLogin($0))
        }
    }
    
    func testValidEmails() {
        let validEmails = [
            "email@example.com",
            "firstname.lastname@example.com",
            "email@subdomain.example.com",
            "firstname+lastname@example.com",
            "email@123.123.123.123",
            "email@[123.123.123.123]",
            "\"email\"@example.com",
            "1234567890@example.com",
            "email@example-one.com",
            "_______@example.com",
            "email@example.name",
            "email@example.museum",
            "email@example.co.jp",
            "firstname-lastname@example.com",
            
        ]
        
        validEmails.forEach {
            XCTAssert(task4.isValidLogin($0))
        }
    }
    
    func testInvalidEmails() {
        let invalidEmails = [
            "#@%^%#$@#$@#.com",
            "@example.com",
            "Joe Smith <email@example.com>",
            "email@example@example.com",
            ".email@example.com",
            "email.@example.com",
            "email..email@example.com",
            "email@example.com (Joe Smith)",
            "email@example",
            "email@-example.com",
            "email@example..com",
            "Abc..123@example.com",
        ]
        
        invalidEmails.forEach {
            let result = task4.isValidLogin($0)
            print("Result: \(result) \($0)")
            XCTAssertFalse(result)
        }
    }

    static var allTests = [
        ("testValidLogins", testValidLogins),
        ("testInvalidLengthLogins", testInvalidLengthLogins),
        ("testInvalidLogins", testInvalidLogins),
        ("testInvalidEmails", testInvalidEmails),
        ("testValidEmails", testValidEmails)
    ]
}
