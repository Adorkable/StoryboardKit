//
//  CollectionViewClassInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 10/30/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Cocoa

public class CollectionViewClassInfo: ViewClassInfo {
    override class var defaultClass : String { return "UICollectionView" }
    
    required public init(className : String?) {
        super.init(className: className)
    }
}
