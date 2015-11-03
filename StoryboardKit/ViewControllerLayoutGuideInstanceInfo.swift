//
//  ViewControllerLayoutGuideInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/1/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a View Controller Layout Guide Instance that is used in your application and its storyboards
public class ViewControllerLayoutGuideInstanceInfo: NSObject, Idable {
    
    /// Storyboard Id
    public let id : String
    
    /// Type - TODO: Enum
    public let type : String
    
    /**
     Default init
     
     - parameter id:   Storyboard Id
     - parameter type: Type
     
     - returns: A new instance.
     */
    public init(id : String, type : String) {
        self.id = id
        self.type = type
        
        super.init()
    }
}
