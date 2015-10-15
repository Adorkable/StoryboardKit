//
//  ViewControllerInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class ViewControllerInstanceInfo: NSObject, Idable {
    public let classInfo : ViewControllerClassInfo
    
    public let id : String
    
    public let storyboardIdentifier : String?
    
    public private(set) var segues = Array< SegueInstanceInfo >()
    
    public private(set) var layoutGuides = Array< ViewControllerLayoutGuideInstanceInfo >()
    
    public private(set) var navigationItems = Array< NavigationItemInstanceInfo >()
    
    public let view : ViewInstanceInfo?
    
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

extension ViewControllerInstanceInfo : CustomDebugStringConvertible {
    override public var debugDescription : String {
        return super.debugDescription + "Id: \(self.id)\(self.classInfo.debugDescription)"
    }
}
