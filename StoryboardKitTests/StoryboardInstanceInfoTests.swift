//
//  StoryboardInstanceInfoTests.swift
//  StoryboardKit
//
//  Created by Ian on 6/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import XCTest

import StoryboardKit

class StoryboardInstanceInfoTests: XCTestCase {
    var applicationInfo : ApplicationInfo?
    
    override func setUp() {
        super.setUp()
        
        applicationInfo = ApplicationInfo()
    }

    // TODO: test that false is being store
    func testUseAutolayout() {
        var result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
        
        var storyboardInstanceInfo = result.0!
        
        XCTAssertTrue(storyboardInstanceInfo.useAutolayout, "Expected useAutolayout in \(storyboardInstanceInfo) to be true")
    }
    
    // TODO: test that false is being store
    func testUseTraitCollections() {
        var result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
        
        var storyboardInstanceInfo = result.0!
        
        XCTAssertTrue(storyboardInstanceInfo.useTraitCollections, "Expected useTraitCollections in \(storyboardInstanceInfo) to be true")
    }
    
    func testInitialViewController() {
        var result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
        
        var storyboardInstanceInfo = result.0!
        
        XCTAssertNotNil(storyboardInstanceInfo.initialViewController, "Expected StoryboardInstanceInfo to contain an initialViewController")
        
        var firstInstanceStoryboardIdentifier = "FirstInstance"
        var firstInstance = applicationInfo?.viewControllerInstanceWithStoryboardIdentifier(firstInstanceStoryboardIdentifier)
        XCTAssertNotNil(firstInstance, "Test Failure: Expected ApplicationInfo to contain a View Controller with Storyboard Identifier \(firstInstanceStoryboardIdentifier)")
        XCTAssertEqual(storyboardInstanceInfo.initialViewController!, firstInstance!, "Expected StoryboardInstanceInfo's initialViewController to be \(firstInstance!), instead it was \(storyboardInstanceInfo.initialViewController!)")
    }
}
