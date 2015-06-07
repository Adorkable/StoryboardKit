//
//  SegueClassInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/4/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class SegueClassInfo: NSObject {
    public let segueClassName : String
    public class var defaultClass : String { return "UIStoryboardSegue" }
    
    public private(set) var instanceInfos = Array< StoryboardInfo_WeakWrapper< SegueInstanceInfo> >()
    
    init(className : String?) {
        if className != nil {
            self.segueClassName = className!
        } else {
            self.segueClassName = SegueClassInfo.defaultClass
        }
        
        super.init()
    }
    
    func add(#instanceInfo : SegueInstanceInfo) {
        self.instanceInfos.append( StoryboardInfo_WeakWrapper(instanceInfo) )
    }
}