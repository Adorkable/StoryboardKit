//
//  TabBarControllerClassInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 10/15/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Tab Bar Controller Class that is used in your application and its storyboards
public class TabBarControllerClassInfo: ViewControllerClassInfo {

    override class var defaultClass : String { return "UITabBarController" }

    /**
     Default init
     
     - parameter className: Name of the Tab Bar Controller class. If nil defaults to UITabBarController
     
     - returns: A new instance.
     */
    required public init(className: String?) {
        super.init(className: className)
    }
}
