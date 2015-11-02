//
//  NavigationControllerInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/1/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Navigation Controller Instance that is used in your application and its storyboards
public class NavigationControllerInstanceInfo: ViewControllerInstanceInfo {
    /// Scene Member Id
    public let sceneMemberId : String?

    /// Segue to Root View
    public var root : SegueInstanceInfo?
    
    /**
     Default init
     
     - parameter classInfo:            Class
     - parameter id:                   Storyboard Id
     - parameter storyboardIdentifier: Storyboard Identifier
     - parameter sceneMemberId:        Scene Member Id
     - parameter root:                 Segue to Root View
     
     - returns: A new instance.
     */
    init(classInfo : NavigationControllerClassInfo, id : String, storyboardIdentifier : String?, sceneMemberId : String?/*, root : SegueInstanceInfo?*/) {
        
        self.sceneMemberId = sceneMemberId
//        self.root = root
        
        super.init(classInfo: classInfo, id: id, storyboardIdentifier: storyboardIdentifier, view: nil)
    }
}
