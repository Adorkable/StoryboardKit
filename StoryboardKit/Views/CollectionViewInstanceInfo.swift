//
//  CollectionViewInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 10/30/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Collection View Instance
public class CollectionViewInstanceInfo: ViewInstanceInfo {
    
    public class CollectionViewCellPrototypeInfo {
        public let id : String
        
        public let reuseIdentifier : String?
        
        init(id : String, reuseIdentifier : String?) {
            self.id = id
            
            self.reuseIdentifier = reuseIdentifier
        }
    }
    
    public var cellPrototypes : [CollectionViewCellPrototypeInfo]?
    
    init(classInfo: ViewClassInfo, id: String, frame: CGRect?, autoResizingMaskWidthSizable: Bool, autoResizingMaskHeightSizable: Bool, subviews: [ViewInstanceInfo]?, backgroundColor: NSColor?, cellPrototypes : [CollectionViewCellPrototypeInfo]?) {
        
        self.cellPrototypes = cellPrototypes
        
        super.init(classInfo: classInfo, id: id, frame: frame, autoResizingMaskWidthSizable: autoResizingMaskWidthSizable, autoResizingMaskHeightSizable: autoResizingMaskHeightSizable, subviews: subviews, backgroundColor: backgroundColor)
    }
}
