//
//  NavigationControllerInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/1/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class NavigationControllerInstanceInfo: ViewControllerInstanceInfo {
    public let sceneMemberId : String?
    
    public var root : SegueInstanceInfo?
    
    init(classInfo : NavigationControllerClassInfo, id : String, storyboardIdentifier : String?, sceneMemberId : String?/*, root : SegueInstanceInfo?*/) {
        
        self.sceneMemberId = sceneMemberId
//        self.root = root
        
        super.init(classInfo: classInfo, id: id, storyboardIdentifier: storyboardIdentifier)
    }
}
