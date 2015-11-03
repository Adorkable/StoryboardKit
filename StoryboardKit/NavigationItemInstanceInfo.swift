//
//  NavigationItemInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/1/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Navigation Item Instance that is used in your application and its storyboards
public class NavigationItemInstanceInfo: NSObject, Idable {
    
    /// Storyboard Id
    public let id : String
    
    /// Navigation Item Key
    public let navigationItemKey : String
    
    /// Title
    public let title : String
    
    /**
     Default init
     
     - parameter id:                Storyboard Id
     - parameter navigationItemKey: Navigation Item Key
     - parameter title:             Title
     
     - returns: A new instance.
     */
    init(id : String, navigationItemKey : String, title : String) {
        self.id = id
        self.navigationItemKey = navigationItemKey
        self.title = title
    }
}
