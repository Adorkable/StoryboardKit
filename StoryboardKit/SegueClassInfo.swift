//
//  SegueClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/4/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Segue Class that is used in your application and its storyboards
public class SegueClassInfo: ClassInfo {
    
    override class var defaultClass : String { return "UIStoryboardSegue" }

    /// All instance of this class in the application
    public private(set) var instanceInfos = Array< StoryboardKit_WeakWrapper< SegueInstanceInfo> >()
    
    /**
     Default init
     
     - parameter className: Name of the Segue class. If nil defaults to UIStoryboardSegue
     
     - returns: A new instance.
     */
    required public init(className : String?) {
        super.init(className: className)
    }
    
    /**
     Add a Segue Instance
     
     - parameter instanceInfo: Segue Instance to add
     */
    func add(instanceInfo instanceInfo : SegueInstanceInfo) {
        self.instanceInfos.append( StoryboardKit_WeakWrapper(instanceInfo) )
    }
}