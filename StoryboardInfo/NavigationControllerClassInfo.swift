//
//  NavigationControllerClassInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

public class NavigationControllerClassInfo: ViewControllerClassInfo {
    override public class var defaultClass : String { return "UINavigationViewController" }
    
    override init(className: String?) {
        var useClassName : String
        if className != nil {
            useClassName = className!
        } else {
            useClassName = NavigationControllerClassInfo.defaultClass
        }
        super.init(className: useClassName)
    }
}
