//
//  StoryboardInfoTests.swift
//  StoryboardKitTests
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa
import XCTest

import StoryboardKit

func storyboardPathBuilder() -> String? {
    var result : String?
    
    if let pwd = NSProcessInfo.processInfo().environment["PWD"] as? String {
        result = pwd + "/StoryboardKitTests/StoryboardKit.storyboard"
    }
    
    return result
}

class StoryboardInfoTests: XCTestCase {
    func testStoryboardPathBuilder() {
        var storyboardPath = storyboardPathBuilder()
        XCTAssertNotNil(storyboardPath, "Storyboard Path is nil")
        
        if storyboardPath != nil
        {
            var fileExists = NSFileManager.defaultManager().fileExistsAtPath(storyboardPath!)
            XCTAssertTrue(fileExists, "Storyboard file does not exist at path \(storyboardPath!)")
        }
    }    
 }
