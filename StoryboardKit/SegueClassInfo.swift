//
//  SegueClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/4/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class SegueClassInfo: ClassInfo {
    
    class var defaultClass : String { return "UIStoryboardSegue" }
    
    public private(set) var instanceInfos = Array< StoryboardKit_WeakWrapper< SegueInstanceInfo> >()
    
    override init(className : String?) {
        
        var useClassName : String
        if className != nil
        {
            useClassName = className!
        } else
        {
            useClassName = SegueClassInfo.defaultClass
        }
        
        super.init(className: useClassName)
    }
    
    func add(#instanceInfo : SegueInstanceInfo) {
        self.instanceInfos.append( StoryboardKit_WeakWrapper(instanceInfo) )
    }
}