//
//  ViewControllerInstanceInfo.swift
//  StoryboardInfo
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
    
    init(classInfo : ViewControllerClassInfo, id : String, storyboardIdentifier : String?) {
        self.classInfo = classInfo
        self.id = id
        
        self.storyboardIdentifier = storyboardIdentifier
        
        super.init()

        self.classInfo.instanceInfos.append( StoryboardInfo_WeakWrapper(value: self) )
    }
    
    func add(#segue : SegueInstanceInfo) {
        self.segues.append(segue)
    }
    
    func add(#layoutGuide : ViewControllerLayoutGuideInstanceInfo) {
        self.layoutGuides.append(layoutGuide)
    }
    
    func add(#navigationItem : NavigationItemInstanceInfo) {
        self.navigationItems.append(navigationItem)
    }
}
