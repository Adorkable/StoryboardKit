//
//  ViewControllerClassInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class ViewControllerClassInfo: NSObject {
    public let viewControllerClassName : String
    public class var defaultClass : String { return "UIViewController" }

    public private(set) var instanceInfos = Array< StoryboardInfo_WeakWrapper<ViewControllerInstanceInfo> >()
    
    init(className : String?) {
        if className != nil
        {
            self.viewControllerClassName = className!
        } else
        {
            self.viewControllerClassName = self.dynamicType.defaultClass
        }
    
        super.init()
    }
    
    func add(#instanceInfo : ViewControllerInstanceInfo) {
        self.instanceInfos.append( StoryboardInfo_WeakWrapper(instanceInfo) )
    }
}
