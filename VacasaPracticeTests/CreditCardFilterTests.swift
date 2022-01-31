//
//  CreditCardFilterTests.swift
//  VacasaPracticeTests
//
//  Created by Tony Mu on 1/02/22.
//

import XCTest
@testable import VacasaPractice

class CreditCardFilterTests: XCTestCase {
    
    let filter = CreditCardFilter()
    
    func test_text_no_number() throws {
        // Arrange
        let text = "Hello, this message does not contain any number"
        
        //Act
        let maskedText = filter.consorString(text)
        
        // Assert
        XCTAssertEqual(maskedText, text)
    }
    
    func test_text_contains_number_less11Digits() throws {
        // Arrange
        let text = "Number with 10 digits: 1234567890"
        
        //Act
        let maskedText = filter.consorString(text)
        
        // Assert
        XCTAssertEqual(maskedText, text)
    }
    
    func test_text_contains_number_morethan11Digit_breaked_by_text() throws {
        // Arrange
        let text = "I'd like to transfer %5,000,000,000,000 into another accout"
        
        //Act
        let maskedText = filter.consorString(text)
        
        // Assert
        XCTAssertEqual(maskedText, text)
    }
    
    func test_text_contains_creditcard() throws {
        // Arrange
        let text1 = "number with 11 digitis:-0-2-1-0-3456789010323"
        
        //Act
        let maskedText1 = filter.consorString(text1)
        
        // Assert
        XCTAssertEqual(maskedText1, "number with 11 digitis:-#-#-#-#-#########0323")
    }
    
}
