//
//  ApplicationInfoTests.swift
//  StoryboardKitTests
//
//  Created by Ian on 5/31/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import XCTest

import StoryboardKit

class ApplicationInfoTests: XCTestCase {
    var storyboardInfo : StoryboardInstanceInfo?
    var applicationInfo : ApplicationInfo?

    override func setUp() {
        super.setUp()
        
        storyboardInfo = StoryboardInstanceInfo()
        applicationInfo = ApplicationInfo()
        
        StoryboardFileParser.parse(applicationInfo!, storyboardInfo: storyboardInfo!, pathFileName: storyboardPathBuilder()! )
    }
    
    func testViewControllerClassWithClassName() {
        var classInfo = applicationInfo!.viewControllerClassWithClassName(ViewControllerClassInfo.defaultClass)
        XCTAssertNotNil(classInfo, "Expected a classInfo for '\(ViewControllerClassInfo.defaultClass)' class")
    }
    
    func testViewControllerInstanceWithInstanceId() {
        var id = "yrP-vr-uHE"
        var instanceInfo = applicationInfo?.viewControllerInstanceWithId(id)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for id '\(id)'")
    }
    
    func testViewControllerInstanceWithStoryboardIdentifier() {
        var storyboardIdentifier = "FirstInstance"
        var instanceInfo = applicationInfo?.viewControllerInstanceWithStoryboardIdentifier(storyboardIdentifier)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for storyboard identifier '\(storyboardIdentifier)'")
    }
    
    func testNavigationControllerInstanceWithId() {
        var id = "eGU-XO-Tph"
        var instanceInfo = applicationInfo?.navigationControllerInstanceWithId(id)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for id '\(id)'")
    }
    
    func testNavigationControllerInstanceWithStoryboardIdentifier() {
        var storyboardIdentifier = "Navigation"
        var instanceInfo = applicationInfo?.navigationControllerInstanceWithStoryboardIdentifier(storyboardIdentifier)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for storyboard identifier '\(storyboardIdentifier)'")
    }
}
