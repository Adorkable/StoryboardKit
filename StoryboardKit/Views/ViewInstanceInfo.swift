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
    /// Class
    public let classInfo : ViewClassInfo
    
    /// Storyboard id
    public let id : String
    
    /// Frame
    public let frame : CGRect? // TODO: should this be non-optional?
    
    /// Autoresizing Mask Width Sizable
    public let autoResizingMaskWidthSizable : Bool
    
    /// Autoresizing Mask Height Sizable
    public let autoResizingMaskHeightSizable : Bool
    
    /// Subviews
    public let subviews : [ViewInstanceInfo]?
    
    /// Background Color
    public let backgroundColor : NSColor?
    
    /**
     Default init
     
     - parameter classInfo:                     Class
     - parameter id:                            Storyboard Id
     - parameter frame:                         frame
     - parameter autoResizingMaskWidthSizable:  Autoresizing Mask Width Sizable
     - parameter autoResizingMaskHeightSizable: Autoresizing Mask Height Sizable
     - parameter subviews:                      Subviews
     - parameter backgroundColor:               Background Color
     
     - returns: A new instance.
     */
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
    
    /// Debug Description
    override public var debugDescription : String {
        return super.debugDescription + "Id: \(self.id)\(self.classInfo.debugDescription)"
    }
}
