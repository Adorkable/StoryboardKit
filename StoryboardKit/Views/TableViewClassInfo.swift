//
//  TableViewClassInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 8/26/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

class TableViewClassInfo: ViewClassInfo {
    override class var defaultClass : String { return "UITableView" }
    
    override init(className : String?) {
        super.init(className: className)
    }
}
