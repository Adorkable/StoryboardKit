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
    
    /// Represents a Table View Cell Prototype
    public class TableViewCellPrototypeInfo {
        /// Storyboard Id
        public let id : String
        
        /// Reuse Identifier
        public let reuseIdentifier : String?
        
        /**
         Default init
         
         - parameter id:              Storyboard Id
         - parameter reuseIdentifier: Reuse Identifier
         
         - returns: A new TableViewCellPrototypeInfo instance
         */
        init(id : String, reuseIdentifier : String?) {
            self.id = id
            
            self.reuseIdentifier = reuseIdentifier
        }
    }
    
    /// All Cell Prototypes contained in this Table View Instance
    public let cellPrototypes : [TableViewCellPrototypeInfo]?
    
    /**
     Default init
     
     - parameter classInfo:                     Class
     - parameter id:                            Storyboard Id
     - parameter frame:                         Frame
     - parameter autoResizingMaskWidthSizable:  Autoresizing Mask Width Sizable
     - parameter autoResizingMaskHeightSizable: Autoresizing Mask Height Sizable
     - parameter subviews:                      Subviews
     - parameter backgroundColor:               Background Color
     - parameter cellPrototypes:                Cell Prototypes
     
     - returns: A new CollectionViewInstanceInfo instance
     */
    init(classInfo: ViewClassInfo, id: String, frame: CGRect?, autoResizingMaskWidthSizable: Bool, autoResizingMaskHeightSizable: Bool, subviews: [ViewInstanceInfo]?, backgroundColor: NSColor?, cellPrototypes : [TableViewCellPrototypeInfo]?) {
        
        self.cellPrototypes = cellPrototypes
        
        super.init(classInfo: classInfo, id: id, frame: frame, autoResizingMaskWidthSizable: autoResizingMaskWidthSizable, autoResizingMaskHeightSizable: autoResizingMaskHeightSizable, subviews: subviews, backgroundColor: backgroundColor)
    }
}