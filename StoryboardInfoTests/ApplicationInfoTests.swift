//
//  ApplicationInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/31/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import XCTest

import StoryboardInfo

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
        var instanceId = "yrP-vr-uHE"
        var instanceInfo = applicationInfo?.viewControllerInstanceWithInstanceId(instanceId)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for instance id '\(instanceId)'")
    }
    
    func testViewControllerInstanceWithStoryboardIdentifier() {
        var storyboardIdentifier = "FirstInstance"
        var instanceInfo = applicationInfo?.viewControllerInstanceWithStoryboardIdentifier(storyboardIdentifier)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for storyboard identifier '\(storyboardIdentifier)'")
    }
}
