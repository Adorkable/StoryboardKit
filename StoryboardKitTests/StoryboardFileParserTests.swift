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
        super.setUp()
        
        applicationInfo = ApplicationInfo()
    }

    func testParseFinishes() {
        StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )

        XCTAssert(true, "Pass")
    }
    
    func testParseFinishedWithStoryboardInstanceInfo() {
        var result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
    }
    
    func testParseFinishesWithoutErrors() {
        var result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNil(result.1, "Error occurred \(result.1)")
    }
}
