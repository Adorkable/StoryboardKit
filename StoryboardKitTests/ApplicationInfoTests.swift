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
    var applicationInfo : ApplicationInfo?

    override func setUp() {
        super.setUp()
        
        applicationInfo = ApplicationInfo()
        
        do
        {
            try StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        } catch let error as NSError
        {
            XCTAssertNil(error, "Expected parse to not throw an error: \(error)")
        }
    }
    
    func testViewControllerClassWithClassName() {
        let className = "UIViewController"
        let classInfo = applicationInfo!.viewControllerClassWithClassName(className)
        XCTAssertNotNil(classInfo, "Expected a classInfo for '\(className)' class")
    }
    
    func testViewControllerInstanceWithInstanceId() {
        let id = "yrP-vr-uHE"
        let instanceInfo = applicationInfo?.viewControllerInstanceWithId(id)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for id '\(id)'")
    }
    
    func testViewControllerInstanceWithStoryboardIdentifier() {
        let storyboardIdentifier = "FirstInstance"
        let instanceInfo = applicationInfo?.viewControllerInstanceWithStoryboardIdentifier(storyboardIdentifier)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for storyboard identifier '\(storyboardIdentifier)'")
    }
    
    func testNavigationControllerInstanceWithId() {
        let id = "eGU-XO-Tph"
        let instanceInfo = applicationInfo?.navigationControllerInstanceWithId(id)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for id '\(id)'")
    }
    
    func testNavigationControllerInstanceWithStoryboardIdentifier() {
        let storyboardIdentifier = "Navigation"
        let instanceInfo = applicationInfo?.navigationControllerInstanceWithStoryboardIdentifier(storyboardIdentifier)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for storyboard identifier '\(storyboardIdentifier)'")
    }
    
    func testSegueClassWithClassName() {
        let className = "UIStoryboardSegue"
        let classInfo = applicationInfo?.segueClassWithClassName(className)
        XCTAssertNotNil(classInfo, "Expected a classInfo for '\(className)' class")
    }
    
    func testViewClassWithClassName() {
        let className = "UIView"
        let classInfo = applicationInfo?.viewClassWithClassName(className)
        XCTAssertNotNil(classInfo, "Expected a classInfo for '\(className)' class")
    }
    
    func testViewClassWithCustomClassName() {
        let className = "CustomButton"
        let classInfo = applicationInfo?.viewClassWithClassName(className)
        XCTAssertNotNil(classInfo, "Expected a classInfo for '\(className)' class")
    }
    
    func testViewInstanceWithId() {
        let id = "IKn-pG-61R"
        let instanceInfo = applicationInfo?.viewInstanceWithId(id)
        XCTAssertNotNil(instanceInfo, "Expected an instanceInfo for id '\(id)'")
    }
    
    func testExitInfoWithId() {
        let id = "LJ5-vW-PYc"
        let exitInfo = applicationInfo?.exitWithId(id)
        XCTAssertNotNil(exitInfo, "Expected an instanceInfo for id '\(id)'")
    }
}
