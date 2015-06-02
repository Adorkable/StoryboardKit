//
//  SegueInstanceInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

public typealias SegueConnection = StoryboardInfo_Either< StoryboardInfo_WeakWrapper<ViewControllerInstanceInfo>, StoryboardInfo_WeakWrapper<NavigationControllerInstanceInfo> >

public class SegueInstanceInfo: NSObject, Idable {
    public let classInfo : SegueClassInfo
    public let id : String
    public var source : SegueConnection?
    public let kind : String?
    public let identifier : String?
    
    public let destinationId : String
    // TODO: lame to have destination optional as a side effect of parsing process, FIX
    public var destination : SegueConnection?
    
    init(classInfo : SegueClassInfo, id : String, source : ViewControllerInstanceInfo, destinationId : String, kind : String?, identifier : String?) {
        self.classInfo = classInfo
        self.id = id
        self.source = StoryboardInfo_Either.Left( StoryboardInfo_WeakWrapper(source) )
        self.destinationId = destinationId
        self.kind = kind
        self.identifier = identifier
        
        super.init()
        
        self.classInfo.add(instanceInfo: self)
    }
    
    init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destinationId : String, kind : String?, identifier : String?) {
        self.classInfo = classInfo
        self.id = id
        self.source = source
        self.destinationId = destinationId
        self.kind = kind
        self.identifier = identifier
        
        super.init()
        
        self.classInfo.add(instanceInfo: self)
    }
}
