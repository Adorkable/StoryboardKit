//
//  ViewInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a View Instance
public class ViewInstanceInfo: NSObject {
    public let classInfo : ViewClassInfo
    
    public let id : String
    
    public let frame : CGRect? // TODO: should this be non-optional?
    
    public let autoResizingMaskWidthSizable : Bool
    public let autoResizingMaskHeightSizable : Bool
    
    public let subviews : [ViewInstanceInfo]?
    
    public let backgroundColor : NSColor?
    
    init(classInfo : ViewClassInfo, id : String, frame : CGRect?, autoResizingMaskWidthSizable : Bool, autoResizingMaskHeightSizable : Bool, subviews : [ViewInstanceInfo]?, backgroundColor : NSColor?) {
        self.classInfo = classInfo
        self.id = id
        
        self.frame = frame
        
        self.autoResizingMaskWidthSizable = autoResizingMaskWidthSizable
        self.autoResizingMaskHeightSizable = autoResizingMaskHeightSizable
        
        self.subviews = subviews
        
        self.backgroundColor = backgroundColor
        
        super.init()
        
        self.classInfo.add(instanceInfo: self)
    }
}


extension ViewInstanceInfo : CustomDebugStringConvertible {
    override public var debugDescription : String {
        return super.debugDescription + "Id: \(self.id)\(self.classInfo.debugDescription)"
    }
}
