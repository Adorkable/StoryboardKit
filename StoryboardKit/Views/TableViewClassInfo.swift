//
//  TableViewClassInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 8/26/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

/// Represents a Table View Class that is used in your application and its storyboards
public class TableViewClassInfo: ViewClassInfo {
    override class var defaultClass : String { return "UITableView" }
    
    required public init(className : String?) {
        super.init(className: className)
    }
}
