//
//  StoryboardFileParserTests.swift
//  StoryboardInfo
//
//  Created by Ian on 5/31/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import XCTest

import StoryboardInfo

class StoryboardFileParserTests: XCTestCase {
    var storyboardInfo : StoryboardInstanceInfo?
    var applicationInfo : ApplicationInfo?
    
    override func setUp() {
        super.setUp()
        
        storyboardInfo = StoryboardInstanceInfo()
        applicationInfo = ApplicationInfo()
    }

    func testParseFinishes() {
        StoryboardFileParser.parse(applicationInfo!, storyboardInfo: storyboardInfo!, pathFileName: storyboardPathBuilder()! )

        XCTAssert(true, "Pass")
    }
}
