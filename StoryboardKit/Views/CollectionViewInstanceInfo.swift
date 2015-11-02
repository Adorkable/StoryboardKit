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
    
    /// Represents a Collection View Cell Prototype
    public class CollectionViewCellPrototypeInfo {
        /// Storyboard Id
        public let id : String
        
        /// Reuse Identifier
        public let reuseIdentifier : String?
        
        /**
         Default init
         
         - parameter id:              Storyboard Id
         - parameter reuseIdentifier: Reuse Identifier
         
         - returns: A new CollectionViewCellPrototypeInfo instance
         */
        init(id : String, reuseIdentifier : String?) {
            self.id = id
            
            self.reuseIdentifier = reuseIdentifier
        }
    }
    
    /// All Cell Prototypes contained in this Collection View Instance
    public let cellPrototypes : [CollectionViewCellPrototypeInfo]?
    
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
    init(classInfo: ViewClassInfo, id: String, frame: CGRect?, autoResizingMaskWidthSizable: Bool, autoResizingMaskHeightSizable: Bool, subviews: [ViewInstanceInfo]?, backgroundColor: NSColor?, cellPrototypes : [CollectionViewCellPrototypeInfo]?) {
        
        self.cellPrototypes = cellPrototypes
        
        super.init(classInfo: classInfo, id: id, frame: frame, autoResizingMaskWidthSizable: autoResizingMaskWidthSizable, autoResizingMaskHeightSizable: autoResizingMaskHeightSizable, subviews: subviews, backgroundColor: backgroundColor)
    }
}
