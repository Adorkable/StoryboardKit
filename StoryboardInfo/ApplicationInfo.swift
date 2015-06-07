//
//  ApplicationInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

public class ApplicationInfo: NSObject {
    public private(set) var viewControllerClasses = Array<ViewControllerClassInfo>()
    
    // TODO: validates that this isn't a dup
    func add(#viewControllerClass : ViewControllerClassInfo) {
        self.viewControllerClasses.append(viewControllerClass)
    }
    
    public func viewControllerClassWithClassName(className : String?) -> ViewControllerClassInfo? {
        return self.viewControllerClasses.filter(
            {
                $0.viewControllerClassName == className
        } ).first
    }
    
    public private(set) var viewControllerInstances = Array<ViewControllerInstanceInfo>()
    
    // TODO: validates that this isn't a dup
    func add(#viewControllerInstance : ViewControllerInstanceInfo) {
        self.viewControllerInstances.append(viewControllerInstance)
    }
    
    public func viewControllerInstanceWithId(id : String) -> ViewControllerInstanceInfo? {
        return firstObjectWithId(id, self.viewControllerInstances)
    }
    
    public func viewControllerInstanceWithStoryboardIdentifier(identifier : String) -> ViewControllerInstanceInfo? {
        return self.viewControllerInstances.filter( { $0.storyboardIdentifier == identifier} ).first
    }
    
    public private(set) var navigationControllerInstances = Array<NavigationControllerInstanceInfo>()
    
    // TODO: validates that this isn't a dup
    func add(#navigationControllerInstance : NavigationControllerInstanceInfo) {
        self.navigationControllerInstances.append(navigationControllerInstance)
    }
    
    public func navigationControllerInstanceWithId(id : String) -> NavigationControllerInstanceInfo? {
        return firstObjectWithId(id, self.navigationControllerInstances)
    }
    
    public func navigationControllerInstanceWithStoryboardIdentifier(identifier : String) -> NavigationControllerInstanceInfo? {
        return self.navigationControllerInstances.filter( { $0.storyboardIdentifier == identifier} ).first
    }
    
    public private(set) var segueClasses = Array<SegueClassInfo>()
    
    // TODO: validates that this isn't a dup
    func add(#segueClass : SegueClassInfo) {
        self.segueClasses.append(segueClass)
    }
    
    public func segueClassWithClassName(className : String?) -> SegueClassInfo? {
        return self.segueClasses.filter( { $0.className == className } ).first
    }
    
    // TODO: store SegueInstances
}
