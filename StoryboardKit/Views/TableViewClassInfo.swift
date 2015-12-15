//
//  TableViewClassInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 8/26/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Table View Class that is used in your application and its storyboards
public class TableViewClassInfo: ViewClassInfo {
    override public class var defaultClass : String { return "UITableView" }
    
    /**
     Default init
     
     - parameter className: name of the Class. If nil defaults to UITableView.
     
     - returns: A new TableViewClassInfo
     */
    required public init(className : String?) {
        super.init(className: className)
    }
}
