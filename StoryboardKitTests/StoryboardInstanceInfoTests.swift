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
        self.continueAfterFailure = false
        
        super.setUp()
        
        applicationInfo = ApplicationInfo()
    }

    // TODO: test that false is being store
    func testUseAutolayout() {
        let result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
        
        let storyboardInstanceInfo = result.0!
        
        XCTAssertTrue(storyboardInstanceInfo.useAutolayout, "Expected useAutolayout in \(storyboardInstanceInfo) to be true")
    }
    
    // TODO: test that false is being store
    func testUseTraitCollections() {
        let result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
        
        let storyboardInstanceInfo = result.0!
        
        XCTAssertTrue(storyboardInstanceInfo.useTraitCollections, "Expected useTraitCollections in \(storyboardInstanceInfo) to be true")
    }
    
    func testInitialViewController() {
        let result = StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        XCTAssertNotNil(result.0, "returned StoryboardInstanceInfo reference is nil")
        
        let storyboardInstanceInfo = result.0!
        
        XCTAssertNotNil(storyboardInstanceInfo.initialViewController, "Expected StoryboardInstanceInfo to contain an initialViewController")
        
        let firstInstanceStoryboardIdentifier = "FirstInstance"
        let firstInstance = applicationInfo?.viewControllerInstanceWithStoryboardIdentifier(firstInstanceStoryboardIdentifier)
        XCTAssertNotNil(firstInstance, "Test Failure: Expected ApplicationInfo to contain a View Controller with Storyboard Identifier \(firstInstanceStoryboardIdentifier)")
        XCTAssertEqual(storyboardInstanceInfo.initialViewController!, firstInstance!, "Expected StoryboardInstanceInfo's initialViewController to be \(firstInstance!), instead it was \(storyboardInstanceInfo.initialViewController!)")
    }
}
