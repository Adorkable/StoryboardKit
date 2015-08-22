//
//  ViewInstanceInfoTests.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import XCTest

import StoryboardKit

class ViewInstanceInfoTests: XCTestCase {
    var applicationInfo : ApplicationInfo?
    
    var viewInstanceInfoId = "IKn-pG-61R"
    var viewInstanceInfo : ViewInstanceInfo?
    
    override func setUp() {
        super.setUp()
        
        applicationInfo = ApplicationInfo()
        
        StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        self.viewInstanceInfo = applicationInfo?.viewInstanceWithId(self.viewInstanceInfoId)
    }
    
    func testAssumptions() {
        XCTAssertNotNil(self.viewInstanceInfo, "Unable to retrieve ViewInstanceInfo with id \(self.viewInstanceInfoId)")
    }
    
    func testClassInfo() {
        var className = "UIView"
        var classInfo = self.applicationInfo?.viewClassWithClassName(className)

        XCTAssertNotNil(classInfo, "\(self.viewInstanceInfo!)'s classInfo should not be nil")
        
        XCTAssertEqual(self.viewInstanceInfo!.classInfo, classInfo!, "\(self.viewInstanceInfo!)'s classInfo should be equal to \(classInfo!)")
    }
    
    func testId() {
        XCTAssertEqual(self.viewInstanceInfo!.id, self.viewInstanceInfoId, "\(self.viewInstanceInfo!)'s id should be equal to \(self.viewInstanceInfo)")
    }
    
    func testFrame() {
        var equalTo = CGRect(x: 0, y: 0, width: 600, height: 600)
        
//        XCTAssertNotNil(self.viewInstanceInfo!.frame, "\(self.viewInstanceInfo)'s frame should not be nil")

        XCTAssertEqual(self.viewInstanceInfo!.frame!, equalTo, "\(self.viewInstanceInfo!)'s frame should be equal to \(equalTo)")
    }
    
    func testAutoResizingMaskWidthSizable() {
        var equalTo = true
        
        XCTAssertEqual(self.viewInstanceInfo!.autoResizingMaskWidthSizable, equalTo, "\(self.viewInstanceInfo!)'s autoResizingMaskWidthSizable should be equal to \(equalTo)")
    }
    
    func testAutoResizingMaskHeightSizable() {
        var equalTo = true
        
        XCTAssertEqual(self.viewInstanceInfo!.autoResizingMaskHeightSizable, equalTo, "\(self.viewInstanceInfo!)'s autoResizingMaskHeightSizable should be equal to \(equalTo)")
    }
    
    func testSubviews() {
        var equalTo = 3
        
        XCTAssertNotNil(self.viewInstanceInfo!.subviews, "\(self.viewInstanceInfo!)'s subviews should not be nil")
        XCTAssertEqual(self.viewInstanceInfo!.subviews!.count, equalTo, "\(self.viewInstanceInfo!)'s subview count should be equal to \(equalTo)")
    }
    
    func testBackgroundColor() {
        var equalTo = NSColor(calibratedWhite: 0.66666666666666663, alpha: 1.0)
        
        XCTAssertNotNil(self.viewInstanceInfo!.backgroundColor, "\(self.viewInstanceInfo!)'s background color should not be nil")
        XCTAssertEqual(self.viewInstanceInfo!.backgroundColor!, equalTo, "\(self.viewInstanceInfo!)'s background color count should be equal to \(equalTo)")
    }
}
