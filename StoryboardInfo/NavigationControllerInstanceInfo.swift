//
//  NavigationControllerInstanceInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 6/1/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class NavigationControllerInstanceInfo: NSObject {
    public let id : String
    
    public let storyboardIdentifier : String?
    public let sceneMemberId : String?
    
    public var root : SegueInstanceInfo?
    
    init(id : String, storyboardIdentifier : String?, sceneMemberId : String?) {
        self.id = id
        self.storyboardIdentifier = storyboardIdentifier
        self.sceneMemberId = sceneMemberId
    }
}
