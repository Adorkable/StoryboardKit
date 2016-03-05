//
//  SeguesParserTests.swift
//  StoryboardKit
//
//  Created by Иван Ушаков on 05.03.16.
//  Copyright © 2016 Adorkable. All rights reserved.
//

import XCTest
import StoryboardKit

class SeguesParserTests: XCTestCase {
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
    
    func testSegueToViewController()
    {
        let controllerId = "yrP-vr-uHE"
        let segueId = "xc1-Tr-pEN"
        let vc = applicationInfo?.viewControllerInstanceWithId(controllerId)
        let segueInstanceInfo =  vc?.segues.filter({ $0.id == segueId }).first
        
        XCTAssertNotNil(segueInstanceInfo, "Expected an instanceInfo for id '\(segueId)'")
    }

    func testSegueToNavigationController()
    {
        let controllerId = "yrP-vr-uHE"
        let segueId = "u81-LE-hlt"
        let vc = applicationInfo?.viewControllerInstanceWithId(controllerId)
        let segueInstanceInfo =  vc?.segues.filter({ $0.id == segueId }).first
        
        XCTAssertNotNil(segueInstanceInfo, "Expected an instanceInfo for id '\(segueId)'")
    }
    
    func testSegueToTabBarController()
    {
        let controllerId = "yrP-vr-uHE"
        let segueId = "wkX-5z-H6g"
        let vc = applicationInfo?.viewControllerInstanceWithId(controllerId)
        let segueInstanceInfo =  vc?.segues.filter({ $0.id == segueId }).first
        
        XCTAssertNotNil(segueInstanceInfo, "Expected an instanceInfo for id '\(segueId)'")
    }
    
    func testSegueToExit()
    {
        let controllerId = "yrP-vr-uHE"
        let segueId = "zln-49-hXf"
        let vc = applicationInfo?.viewControllerInstanceWithId(controllerId)
        let segueInstanceInfo =  vc?.segues.filter({ $0.id == segueId }).first
        
        XCTAssertNotNil(segueInstanceInfo, "Expected an instanceInfo for id '\(segueId)'")
    }
}
