//
//  ViewControllerInstanceInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

public class ViewControllerInstanceInfo: NSObject {
    let classInfo : ViewControllerClassInfo
    
    let instanceId : String
    
    let storyboardIdentifier : String?
    
    private var segues = Array< SegueInstanceInfo >()
    
    init(classInfo : ViewControllerClassInfo, instanceId : String, storyboardIdentifier : String?) {
        self.classInfo = classInfo
        self.instanceId = instanceId
        
        self.storyboardIdentifier = storyboardIdentifier
        
        super.init()

        self.classInfo.instanceInfos.append( StoryboardInfo_WeakWrapper(value: self) )
    }
    
    func add(#segue : SegueInstanceInfo) {
        self.segues.append(segue)
    }
}
