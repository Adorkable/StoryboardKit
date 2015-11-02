//
//  TabBarControllerInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian Grossberg on 10/15/15.
//  Copyright © 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Tab Bar Controller Instance that is used in your application and its storyboards
public class TabBarControllerInstanceInfo: ViewControllerInstanceInfo {

    /**
     Default init
     
     - parameter classInfo:            Class
     - parameter id:                   Storyboard Id
     - parameter storyboardIdentifier: Storyboard Identifier
     - parameter view:                 View
     
     - returns: A new instance.
     */
    public override init(classInfo : ViewControllerClassInfo, id : String, storyboardIdentifier : String?, view : ViewInstanceInfo?) {
        
        super.init(classInfo: classInfo, id: id, storyboardIdentifier: storyboardIdentifier, view: view)
    }
}
