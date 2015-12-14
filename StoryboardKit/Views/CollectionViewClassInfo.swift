//
//  CollectionViewClassInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 10/30/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Collection View Class that is used in your application and its storyboards
public class CollectionViewClassInfo: ViewClassInfo {
    override public class var defaultClass : String { return "UICollectionView" }
    
    /**
     Default init
     
     - parameter className: name of the Class. If nil defaults to UICollectionView.
     
     - returns: A new CollectionViewClassInfo
     */
    required public init(className : String?) {
        super.init(className: className)
    }
}
