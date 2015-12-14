//
//  ViewClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/**
*  Represents a View Class that is used in your application and its storyboards
*/
public class ViewClassInfo: ClassInfo {

    override public class var defaultClass : String { return "UIView" }

    /// All instances of this class in the application
    public private(set) var instanceInfos = [StoryboardKit_WeakWrapper<ViewInstanceInfo>]()

    /**
    Default init
    
    - parameter className: name of the View class. If nil defaults to UIView.
    
    - returns: A new ViewClassInfo instance
    */
    required public init(className : String?) {
        super.init(className: className)
    }
    
    /**
    Add a View instance of this class
    
    - parameter instanceInfo: Instance Info of a View of this class
    */
    func add(instanceInfo instanceInfo : ViewInstanceInfo) {
        // TODO: prevent duplicates
        self.instanceInfos.append( StoryboardKit_WeakWrapper(instanceInfo) )
    }
}
