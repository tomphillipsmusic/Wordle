//
//  WordleTests.swift
//  WordleTests
//
//  Created by Tom Phillips on 1/30/22.
//

import XCTest
@testable import Wordle

class WordleTests: XCTestCase {

    var systemUnderTest: WordleGame!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = WordleGame(library: TestLibrary())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        systemUnderTest = nil
    }
    
    func testGuessingWordLengthLessThanLibraryWordLengthIsInvalid() {
        // Given
        systemUnderTest.currentGuess.value = "wordle"

        
        // When
        systemUnderTest.guess()
        
        // Then
        XCTAssert(systemUnderTest.isGuessInvalid == true)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
