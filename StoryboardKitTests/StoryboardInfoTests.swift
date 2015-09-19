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
    
    if let path = (NSProcessInfo.processInfo().environment["XCTestConfigurationFilePath"] as NSString?)?.stringByDeletingLastPathComponent {
        result = path + "/StoryboardKit.storyboard"
    }
    
    return result
}

class StoryboardInfoTests: XCTestCase {
    func testStoryboardPathBuilder() {
        let storyboardPath = storyboardPathBuilder()
        XCTAssertNotNil(storyboardPath, "Storyboard Path is nil")
        
        if storyboardPath != nil
        {
            let fileExists = NSFileManager.defaultManager().fileExistsAtPath(storyboardPath!)
            XCTAssertTrue(fileExists, "Storyboard file does not exist at path \(storyboardPath!)")
        }
    }    
 }
