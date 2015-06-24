//
//  SegueInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

public typealias SegueConnection = StoryboardKit_WeakWrapper<ViewControllerInstanceInfo>

public class SegueInstanceInfo: NSObject, Idable, DebugPrintable {
    public let classInfo : SegueClassInfo
    public let id : String
    public let source : SegueConnection
    public let destination : SegueConnection
    public let kind : String?
    public let identifier : String?
    
    public init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destination : SegueConnection, kind : String?, identifier : String?) {
        self.classInfo = classInfo
        self.id = id
        self.source = source
        self.destination = destination
        self.kind = kind
        self.identifier = identifier
        
        super.init()
        
        self.classInfo.add(instanceInfo: self)
    }
    
    public convenience init(classInfo : SegueClassInfo, id : String, source : ViewControllerInstanceInfo, destination : ViewControllerInstanceInfo, kind : String?, identifier : String?) {
        self.init(classInfo: classInfo, id: id, source: StoryboardKit_WeakWrapper(source), destination: StoryboardKit_WeakWrapper(destination), kind: kind, identifier: identifier)
    }
 
    public convenience init(classInfo : SegueClassInfo, id : String, source : ViewControllerInstanceInfo, destination : SegueConnection, kind : String?, identifier : String?) {
        self.init(classInfo: classInfo, id: id, source: StoryboardKit_WeakWrapper(source), destination: destination, kind: kind, identifier: identifier)
    }

    public convenience init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destination : ViewControllerInstanceInfo, kind : String?, identifier : String?) {
        self.init(classInfo: classInfo, id: id, source: source, destination: StoryboardKit_WeakWrapper(destination), kind: kind, identifier: identifier)
    }
    
    override public var debugDescription : String {
        get {
            var result = super.debugDescription
            
            result += "\n\(self.classInfo)"
            result += "\nId: \(self.id)"
            result += "\nSource: \(self.source.value)"
            result += "\nDestination: \(self.destination.value)"
            result += "\nKind: \(self.kind)"
            result += "\nIdentifier: \(self.identifier)"
            
            return result
        }
    }
}
