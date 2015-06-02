//
//  SegueInstanceInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

typealias SegueConnection = StoryboardInfo_Either< StoryboardInfo_Weak<ViewControllerInstanceInfo>, StoryboardInfo_Weak<NavigationControllerInstanceInfo> >

public class SegueInstanceInfo: NSObject, Idable {
    var classInfo : SegueClassInfo
    let id : String
    var source : SegueConnection?
    let kind : String?
    let identifier : String?
    
    var destinationId : String
    // TODO: lame to have destination optional as a side effect of parsing process, FIX
    var destination : SegueConnection?
    
    init(classInfo : SegueClassInfo, id : String, source : ViewControllerInstanceInfo, destinationId : String, kind : String?, identifier : String?) {
        self.classInfo = classInfo
        self.id = id
        self.source = StoryboardInfo_Either.Left( StoryboardInfo_Weak(source) )
        self.destinationId = destinationId
        self.kind = kind
        self.identifier = identifier
        
        super.init()
        
        self.classInfo.instanceInfos.append( StoryboardInfo_WeakWrapper(value: self) )
    }
    
    init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destinationId : String, kind : String?, identifier : String?) {
        self.classInfo = classInfo
        self.id = id
        self.source = source
        self.destinationId = destinationId
        self.kind = kind
        self.identifier = identifier
        
        super.init()
        
        self.classInfo.instanceInfos.append( StoryboardInfo_WeakWrapper(value: self) )
    }
}
