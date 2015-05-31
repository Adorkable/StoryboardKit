//
//  ApplicationInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Cocoa

public class ApplicationInfo: NSObject {
    private var viewControllerClasses = Array<ViewControllerClassInfo>()
    
    // TODO: validates that this isn't a dup
    func add(#viewControllerClass : ViewControllerClassInfo) {
        self.viewControllerClasses.append(viewControllerClass)
    }
    
    public func viewControllerClassWithClassName(className : String?) -> ViewControllerClassInfo? {
        return self.viewControllerClasses.filter(
            {
                $0.customClass == className ||
                $0.customClass == nil && className == ViewControllerClassInfo.defaultClass
        } ).first
    }
    
    private var viewControllerInstances = Array<ViewControllerInstanceInfo>()
    
    // TODO: validates that this isn't a dup
    func add(#viewControllerInstance : ViewControllerInstanceInfo) {
        self.viewControllerInstances.append(viewControllerInstance)
    }
    
    public func viewControllerInstanceWithInstanceId(instanceId : String) -> ViewControllerInstanceInfo? {
        return self.viewControllerInstances.filter( { $0.instanceId == instanceId } ).first
    }
    
    public func viewControllerInstanceWithStoryboardIdentifier(identifier : String) -> ViewControllerInstanceInfo? {
        return self.viewControllerInstances.filter( { $0.storyboardIdentifier == identifier} ).first
    }
    
    private var segueClasses = Array<SegueClassInfo>()
    
    // TODO: validates that this isn't a dup
    func add(#segueClass : SegueClassInfo) {
        self.segueClasses.append(segueClass)
    }
    
    public func segueClassWithClassName(className : String?) -> SegueClassInfo? {
        return self.segueClasses.filter( { $0.customClass == className } ).first
    }
}
