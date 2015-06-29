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
public class ViewClassInfo: NSObject {
    /// Name of the Class
    public let viewClassName : String
    class var defaultClass : String { return "UIView" }

    /// All instances of this class in the application
    public private(set) var instanceInfos = [StoryboardKit_WeakWrapper<ViewInstanceInfo>]()

    /**
    Default init
    
    :param: className name of the View class
    
    :returns: A new ViewClassInfo instance
    */
    init(className : String?) {
        if className != nil
        {
            self.viewClassName = className!
        } else
        {
            self.viewClassName = self.dynamicType.defaultClass
        }
        
        super.init()
    }
    
    /**
    Add a View instance of this class
    
    :param: instanceInfo Instance Info of a View of this class
    */
    func add(#instanceInfo : ViewInstanceInfo) {
        // TODO: prevent duplicates
        self.instanceInfos.append( StoryboardKit_WeakWrapper(instanceInfo) )
    }
}
