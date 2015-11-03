//
//  NavigationControllerClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Navigation Controller class that is used in your application and its storyboards
public class NavigationControllerClassInfo: ViewControllerClassInfo {
    override class var defaultClass : String { return "UINavigationController" }
    
    /**
     Default init
     
     - parameter className: name of the Navigation Controller class. If nil defaults to UINavigationController.
     
     - returns: A new ViewClassInfo instance
     */
    required public init(className: String?) {
        super.init(className: className)
    }
}
