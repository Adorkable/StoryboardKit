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
public class ViewControllerClassInfo: NSObject {
    /// Name of the Class
    public let viewControllerClassName : String
    class var defaultClass : String { return "UIViewController" }

    /// All instances of this class in the application
    public private(set) var instanceInfos = Array< StoryboardKit_WeakWrapper<ViewControllerInstanceInfo> >()
    
    /**
    Default init
    
    :param: className name of the View Controller class
    
    :returns: A new ViewControllerClassInfo instance
    */
    init(className : String?) {
        if className != nil
        {
            self.viewControllerClassName = className!
        } else
        {
            self.viewControllerClassName = self.dynamicType.defaultClass
        }
    
        super.init()
    }
    
    /**
    Add a View Controller instance of this class
    
    :param: instanceInfo Instance Info of a View Controller of this class
    */
    func add(#instanceInfo : ViewControllerInstanceInfo) {
        // TODO: prevent duplicates
        self.instanceInfos.append( StoryboardKit_WeakWrapper(instanceInfo) )
    }
}

extension ViewControllerClassInfo : DebugPrintable {
    public override var debugDescription: String {
        get {
            var result = super.debugDescription
            
            result += "\nClass: \(self.viewControllerClassName)"
            
            return result
        }
    }
}
