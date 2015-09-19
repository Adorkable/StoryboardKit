//
//  StoryboardFileParserTests.swift
//  StoryboardKitTests
//
//  Created by Ian on 5/31/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import XCTest

import StoryboardKit

class StoryboardFileParserTests: XCTestCase {
    var applicationInfo : ApplicationInfo?
    
    override func setUp() {
        self.continueAfterFailure = false
        
        super.setUp()
        
        applicationInfo = ApplicationInfo()
    }
    
    func testCannotFindStoryboardFile() {
        do
        {
            try StoryboardFileParser.parse(applicationInfo!, pathFileName: "asldkfjlkajdslfkajsldfkjalsdfkjlaskdjflaskjdfa.alskdjflksjf")
            
            XCTAssert(false, "Expected parse to throw an error")
        } catch let error as NSError
        {
            XCTAssertNotNil(error, "Expected parse to throw an error: \(error)")
        }
    }

    func testParseFinishes() {
        do
        {
            try StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        } catch let error as NSError
        {
            XCTAssertNil(error, "Expected parse to not throw an error: \(error)")
        }

        XCTAssert(true, "Pass")
    }
    
    func testParseFinishedWithStoryboardInstanceInfo() {
        var result : StoryboardFileParser.ParseResult
        do
        {
            result = try StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        } catch let error as NSError
        {
            XCTAssertNil(error, "Expected parse to not throw an error: \(error)")
        }
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
    }
    
    func testParseFinishesWithoutErrors() {
        do
        {
            try StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        } catch let error as NSError
        {
            XCTAssertNil(error, "Expected parse to not throw an error: \(error)")
        }
    }
}
