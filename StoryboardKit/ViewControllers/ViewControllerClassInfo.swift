//
//  ViewControllerClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/**
*  Represents a View Controller Class that is used in your application and its storyboards
*/
public class ViewControllerClassInfo: ClassInfo {

    override public class var defaultClass : String { return "UIViewController" }

    /// All instances of this class in the application
    public private(set) var instanceInfos = Array< StoryboardKit_WeakWrapper<ViewControllerInstanceInfo> >()
    
    /**
    Default init
    
    - parameter className: name of the View Controller class. If nil defaults to UIViewController
    
    - returns: A new ViewControllerClassInfo instance
    */
    required public init(className : String?) {
        super.init(className: className)
    }
    
    /**
    Add a View Controller instance of this class
    
    - parameter instanceInfo: Instance Info of a View Controller of this class
    */
    func add(instanceInfo instanceInfo : ViewControllerInstanceInfo) {
        // TODO: prevent duplicates
        self.instanceInfos.append( StoryboardKit_WeakWrapper(instanceInfo) )
    }
}
