//
//  TableViewInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 8/26/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import XCTest

import StoryboardKit

class TableViewInstanceInfoTests: XCTestCase {

    var applicationInfo : ApplicationInfo?
    
    var tableViewInstanceInfoId = "BYg-eK-ujo"
    var tableViewInstanceInfo : TableViewInstanceInfo?
    
    override func setUp() {
        super.setUp()
        
        applicationInfo = ApplicationInfo()
        
        StoryboardFileParser.parse(applicationInfo!, pathFileName: storyboardPathBuilder()! )
        
        if let tableViewInstanceInfo = applicationInfo?.viewInstanceWithId(self.tableViewInstanceInfoId) as? TableViewInstanceInfo
        {
            self.tableViewInstanceInfo = tableViewInstanceInfo
        }
    }
    
    func testAssumptions() {
        XCTAssertNotNil(self.tableViewInstanceInfo, "Unable to retrieve ViewInstanceInfo with id \(self.tableViewInstanceInfoId)")
    }
    
    func testClassInfo() {
        var className = "UITableView"
        var classInfo = self.applicationInfo?.viewClassWithClassName(className)
        
        XCTAssertNotNil(classInfo, "\(self.tableViewInstanceInfo!)'s classInfo should not be nil")
        
        XCTAssertEqual(self.tableViewInstanceInfo!.classInfo, classInfo!, "\(self.tableViewInstanceInfo!)'s classInfo should be equal to \(classInfo!)")
    }

    func testCellPrototypes() {
        XCTAssertNotNil(self.tableViewInstanceInfo!.cellPrototypes, "\(self.tableViewInstanceInfo!) should contain cell prototypes")
        XCTAssertGreaterThan(self.tableViewInstanceInfo!.cellPrototypes!.count, 0, "\(self.tableViewInstanceInfo!)'s cell prototypes count should be greater than 0")
        XCTAssertNotNil(self.tableViewInstanceInfo!.cellPrototypes![0].reuseIdentifier, "\(self.tableViewInstanceInfo!.cellPrototypes![0])'s reuseIdentifier should not be nil")
        
        var reuseIdentifier = "I'm a Table Cell"
        XCTAssertEqual(self.tableViewInstanceInfo!.cellPrototypes![0].reuseIdentifier!, reuseIdentifier, "\(self.tableViewInstanceInfo!.cellPrototypes![0])'s reuseIdentifier should be \"\(reuseIdentifier)\"")
    }
}
