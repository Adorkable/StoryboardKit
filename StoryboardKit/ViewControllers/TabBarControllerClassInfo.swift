//
//  TabBarControllerClassInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 10/15/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

public class TabBarControllerClassInfo: ViewControllerClassInfo {

    override public class var defaultClass : String { return "UITabBarController" }
    
    required public init(className: String?) {
        super.init(className: className)
    }
}
