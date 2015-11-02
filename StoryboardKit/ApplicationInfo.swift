//
//  ApplicationInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/**
*  Contains information global to your application
*/
public class ApplicationInfo: NSObject {
    /// All View Controller Class Infos in your application
    public private(set) var viewControllerClasses = [ViewControllerClassInfo]()

    /**
    Add a View Controller Class Info
    
    - parameter viewControllerClass: View Controller Class Info to add
    */
    func add(viewControllerClass viewControllerClass : ViewControllerClassInfo) {
        // TODO: validates that this isn't a dup
        self.viewControllerClasses.append(viewControllerClass)
    }
    
    /**
    Retrieve a View Controller Class Info by class name
        
    - parameter className: Name of the class you wish to retrieve
    
    - returns: If found a reference to the View Controller Class Info you wished to retrieve, otherwise nil
    */
    public func viewControllerClassWithClassName(className : String) -> ViewControllerClassInfo? {
        return classWithClassName(className, objects: self.viewControllerClasses)
    }
    
    /// All View Controller Instance Infos in your application
    public private(set) var viewControllerInstances = [ViewControllerInstanceInfo]()

    /**
    Add a View Controller Instance Info
    
    - parameter viewControllerInstance: View Controller Instance Info to add
    */
    func add(viewControllerInstance viewControllerInstance : ViewControllerInstanceInfo) {
        // TODO: validates that this isn't a dup
        self.viewControllerInstances.append(viewControllerInstance)
    }
    
    /**
    Retrieve a View Controller Instance Info by Storyboard id
    
    - parameter id: Storyboard id of the instance you wish to retrieve (not to be confused with IB assigned identifier)
    
    - returns: If found a reference to the View Controller Instance Info you wished to retrieve, otherwise nil
    */
    public func viewControllerInstanceWithId(id : String) -> ViewControllerInstanceInfo? {
        return firstObjectWithId(id, objects: self.viewControllerInstances)
    }
    
    /**
    Retrieve a View Controller Instance Info by Storyboard Identifier
    
    - parameter id: Storyboard Identifier of the instance you wish to retrieve
    
    - returns: If found a reference to the View Controller Instance Info you wished to retrieve, otherwise nil
    */
    public func viewControllerInstanceWithStoryboardIdentifier(identifier : String) -> ViewControllerInstanceInfo? {
        return self.viewControllerInstances.filter( { $0.storyboardIdentifier == identifier} ).first
    }
    
    /// All Navigation Controller Instance Infos in your application
    public private(set) var navigationControllerInstances = [NavigationControllerInstanceInfo]()
    
    /**
    Add a Navigation Controller Instance Info to your application
    
    - parameter navigationControllerInstance: Navigation Controller Instance Info to add
    */
    func add(navigationControllerInstance navigationControllerInstance : NavigationControllerInstanceInfo) {
        // TODO: validates that this isn't a dup
        self.navigationControllerInstances.append(navigationControllerInstance)
    }
    
    /**
    Retrieve a Navigation Controller Instance Info by Storyboard id
    
    - parameter id: Storyboard id of the instance you wish to retrieve (not to be confused with IB assigned identifier)
    
    - returns: If found a reference to the Navigation Controller Instance Info you wished to retrieve, otherwise nil
    */
    public func navigationControllerInstanceWithId(id : String) -> NavigationControllerInstanceInfo? {
        return firstObjectWithId(id, objects: self.navigationControllerInstances)
    }
    
    /**
    Retrieve a Navigation Controller Instance Info by Storyboard Identifier
    
    - parameter id: Storyboard Identifier of the instance you wish to retrieve
    
    - returns: If found a reference to the Navigation Controller Instance Info you wished to retrieve, otherwise nil
    */
    public func navigationControllerInstanceWithStoryboardIdentifier(identifier : String) -> NavigationControllerInstanceInfo? {
        return self.navigationControllerInstances.filter( { $0.storyboardIdentifier == identifier} ).first
    }
    
    /// All Tab Bar Controller Instance Infos in your application
    public private(set) var tabBarControllerInstances = [TabBarControllerInstanceInfo]()
    
    /**
    Add a Tab Bar Controller Instance Info to your application
    
    - parameter tabBarControllerInstance: Tab Bar Controller Instance Info to add
    */
    func add(tabBarControllerInstance tabBarControllerInstance : TabBarControllerInstanceInfo) {
        // TODO: validates that this isn't a dup
        self.tabBarControllerInstances.append(tabBarControllerInstance)
    }
    
    /**
    Retrieve a Tab Bar Controller Instance Info by Storyboard id
    
    - parameter id: Storyboard id of the instance you wish to retrieve (not to be confused with IB assigned identifier)
    
    - returns: If found a reference to the Tab Bar Controller Instance Info you wished to retrieve, otherwise nil
    */
    public func tabBarControllerInstanceWithId(id : String) -> TabBarControllerInstanceInfo? {
        return firstObjectWithId(id, objects: self.tabBarControllerInstances)
    }
    
    /**
    Retrieve a Tab Bar Controller Instance Info by Storyboard Identifier
    
    - parameter id: Storyboard Identifier of the instance you wish to retrieve
    
    - returns: If found a reference to the Tab Bar Controller Instance Info you wished to retrieve, otherwise nil
    */
    public func tabBarControllerInstanceWithStoryboardIdentifier(identifier : String) -> TabBarControllerInstanceInfo? {
        return self.tabBarControllerInstances.filter( { $0.storyboardIdentifier == identifier} ).first
    }
    
    /// All Segue Class Infos in your application
    public private(set) var segueClasses = [SegueClassInfo]()

    /**
    Add a Segue Class Info to your application
    
    - parameter segueClass: Segue Class Info to add
    */
    func add(segueClass segueClass : SegueClassInfo) {
        // TODO: validates that this isn't a dup
        self.segueClasses.append(segueClass)
    }
    
    /**
    Retrieve a Segue Class Info by class name
    
    - parameter className: Name of the class you wish to retrieve
    
    - returns: If found a reference to the Segue Class Info you wished to retrieve, otherwise nil
    */
    public func segueClassWithClassName(className : String) -> SegueClassInfo? {
        return classWithClassName(className, objects: self.segueClasses)
    }
    
    // TODO: store SegueInstances
    
    /// All View Class Infos in your application
    public private(set) var viewClasses = [ViewClassInfo]()
    
    /**
    Add a View Class Info to your application
    
    - parameter viewClass: View Class Info to add
    */
    func add(viewClass viewClass : ViewClassInfo) {
        // TODO: validates that this isn't a dup
        self.viewClasses.append(viewClass)
    }
    
    /**
    Retrieve a View Class Info by class name
    
    - parameter className: Name of the class you wish to retrieve
    
    - returns: If found a reference to the View Class Info you wished to retrieve, otherwise nil
    */
    public func viewClassWithClassName(className : String) -> ViewClassInfo? {
        return classWithClassName(className, objects: self.viewClasses)
    }
    
    /**
    Retrieve a View Instance Info by id
    
    - parameter id: id of the instance you wish to retrieve
    
    - returns: If found a reference to the View Instance Info you wished to retrieve, otherwise nil
    */
    public func viewInstanceWithId(id : String) -> ViewInstanceInfo? {
        var result : ViewInstanceInfo?
        
        for viewClass in self.viewClasses
        {
            for viewInstanceWeakWrapper in viewClass.instanceInfos
            {
                if let viewInstance = viewInstanceWeakWrapper.value
                {
                    if viewInstance.id == id
                    {
                        result = viewInstance
                        break
                    }
                }
            }
            
            if result != nil
            {
                break
            }
        }
        
        return result
    }
}
