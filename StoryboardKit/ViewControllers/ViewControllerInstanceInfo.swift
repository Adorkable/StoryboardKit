//
//  ViewControllerInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a View Controller Instance that is used in your application and its storyboards
public class ViewControllerInstanceInfo: NSObject, Idable {
    /// Class
    public let classInfo : ViewControllerClassInfo
    
    /// Storyboard Id
    public let id : String
    
    /// Storyboard Identifier
    public let storyboardIdentifier : String?
    
    /// Segues
    public private(set) var segues = Array< SegueInstanceInfo >()
    
    /// Layout Guides
    public private(set) var layoutGuides = Array< ViewControllerLayoutGuideInstanceInfo >()
    
    /// Navigation Items
    public private(set) var navigationItems = Array< NavigationItemInstanceInfo >()
    
    /// View
    public let view : ViewInstanceInfo?
    
    /**
     Default Init
     
     - parameter classInfo:            Class
     - parameter id:                   Storyboard Id
     - parameter storyboardIdentifier: Storyboard Identifier
     - parameter view:                 View
     
     - returns: A new instance.
     */
    init(classInfo : ViewControllerClassInfo, id : String, storyboardIdentifier : String?, view : ViewInstanceInfo?) {
        self.classInfo = classInfo
        self.id = id
        
        self.storyboardIdentifier = storyboardIdentifier
        
        self.view = view
        
        super.init()

        self.classInfo.add(instanceInfo: self)
    }
    
    func add(segue segue : SegueInstanceInfo) {
        self.segues.append(segue)
    }
    
    func add(layoutGuide layoutGuide : ViewControllerLayoutGuideInstanceInfo) {
        self.layoutGuides.append(layoutGuide)
    }
    
    func add(navigationItem navigationItem : NavigationItemInstanceInfo) {
        self.navigationItems.append(navigationItem)
    }
}

extension ViewControllerInstanceInfo /*: CustomDebugStringConvertible*/ {
    /// Debug Description
    override public var debugDescription : String {
        return super.debugDescription + "Id: \(self.id)\(self.classInfo.debugDescription)"
    }
}
