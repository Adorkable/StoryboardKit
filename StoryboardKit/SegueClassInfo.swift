//
//  SegueClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/4/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class SegueClassInfo: ClassInfo {
    
    override class var defaultClass : String { return "UIStoryboardSegue" }
    
    public private(set) var instanceInfos = Array< StoryboardKit_WeakWrapper< SegueInstanceInfo> >()
    
    required public init(className : String?) {
        super.init(className: className)
    }
    
    func add(instanceInfo instanceInfo : SegueInstanceInfo) {
        self.instanceInfos.append( StoryboardKit_WeakWrapper(instanceInfo) )
    }
}