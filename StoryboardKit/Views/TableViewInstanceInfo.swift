//
//  TableViewInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 8/26/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Table View Instance
public class TableViewInstanceInfo: ViewInstanceInfo {
    
    public class TableViewCellPrototypeInfo {
        public let id : String
        
        public let reuseIdentifier : String?
        
        init(id : String, reuseIdentifier : String?) {
            self.id = id
            
            self.reuseIdentifier = reuseIdentifier
        }
    }
    
    public var cellPrototypes : [TableViewCellPrototypeInfo]?
    
    init(classInfo: ViewClassInfo, id: String, frame: CGRect?, autoResizingMaskWidthSizable: Bool, autoResizingMaskHeightSizable: Bool, subviews: [ViewInstanceInfo]?, backgroundColor: NSColor?, cellPrototypes : [TableViewCellPrototypeInfo]?) {
        
        self.cellPrototypes = cellPrototypes
        
        super.init(classInfo: classInfo, id: id, frame: frame, autoResizingMaskWidthSizable: autoResizingMaskWidthSizable, autoResizingMaskHeightSizable: autoResizingMaskHeightSizable, subviews: subviews, backgroundColor: backgroundColor)
    }
}