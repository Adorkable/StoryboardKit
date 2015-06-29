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

    class var defaultClass : String { return "UIViewController" }

    /// All instances of this class in the application
    public private(set) var instanceInfos = Array< StoryboardKit_WeakWrapper<ViewControllerInstanceInfo> >()
    
    /**
    Default init
    
    :param: className name of the View Controller class
    
    :returns: A new ViewControllerClassInfo instance
    */
    override init(className : String?) {
        
        var useClassName : String
        if className != nil
        {
            useClassName = className!
        } else
        {
            useClassName = self.dynamicType.defaultClass
        }
    
        super.init(className: useClassName)
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
