//
//  SegueInstanceInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

public class SegueInstanceInfo: NSObject {
    var classInfo : SegueClassInfo
    let instanceId : String
    weak var source : ViewControllerInstanceInfo?
    let kind : String?
    let identifier : String?
    
    var destinationId : String
    // TODO: lame to have destination optional as a side effect of parsing process, FIX
    weak var destination : ViewControllerInstanceInfo?
    
    init(classInfo : SegueClassInfo, instanceId : String, source : ViewControllerInstanceInfo, destinationId : String, kind : String?, identifier : String?) {
        self.classInfo = classInfo
        self.instanceId = instanceId
        self.source = source
        self.destinationId = destinationId
        self.kind = kind
        self.identifier = identifier
        
        super.init()
        
        self.classInfo.instanceInfos.append( StoryboardInfo_WeakWrapper(value: self) )
    }
}
