//
//  NavigationControllerClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class NavigationControllerClassInfo: ViewControllerClassInfo {
    override public class var defaultClass : String { return "UINavigationController" }
    
    required public init(className: String?) {
        super.init(className: className)
    }
}
