//
//  DailyNotesTests.swift
//  DailyNotesTests
//
//  Created by Naruth Kongurai on 10/20/17.
//  Copyright © 2017 Naruth Kongurai. All rights reserved.
//

import XCTest
@testable import DailyNotes

class DailyNotesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Note Class Tests
    
    // Confirm that the Note initializer returns a Note object when passed valid parameters
    func testNoteInitializationSucceeds() {
        let currentDate = Date()
        let writtenStringNote = Note.init(date: currentDate, note: "Starting my diary today")
        XCTAssertNotNil(writtenStringNote)
    }
    
    // Comfirm that the NOte initializer returns nil when passed an empty string
    func testNoteInitializerFails() {
        let currentDate = Date()
        let emptyStringNote = Note.init(date: currentDate, note: "")
        XCTAssertNil(emptyStringNote)
    }
}
