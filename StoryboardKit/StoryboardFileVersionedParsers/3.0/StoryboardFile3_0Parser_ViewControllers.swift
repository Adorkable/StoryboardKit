//
//  StoryboardFile3_0Parser_ViewControllers.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

internal extension StoryboardFile3_0Parser {
    // MARK: View Controllers
    
    internal class func useClass(element : XMLElement, classInfo : ViewControllerClassInfo.Type) -> String
    {
        var result : String
        if let customClass = element.attributes["customClass"]
        {
            result = customClass
        } else
        {
            result = classInfo.defaultClass
        }
        return result
    }
    
    internal func findOrCreateViewControllerClassInfo(useClass : String, classInfo : ViewControllerClassInfo.Type) -> ViewControllerClassInfo
    {
        let result : ViewControllerClassInfo
        
        if let controllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(useClass) // TODO: as? classInfo
        {
            result = controllerClassInfo
        } else
        {
            result = classInfo.init(className: useClass)
            self.applicationInfo.add(viewControllerClass: result)
        }
        
        return result
    }
    
    internal func parseViewController(viewController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = viewController.element,
            let id = element.attributes["id"]
        {
            let useClass = StoryboardFile3_0Parser.useClass(element, classInfo: ViewControllerClassInfo.self)
            
            var viewControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(useClass)
            if viewControllerClassInfo == nil
            {
                viewControllerClassInfo = ViewControllerClassInfo(className: useClass)
                self.applicationInfo.add(viewControllerClass: viewControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            
            var view : ViewInstanceInfo? // Should be using view.key attribute?
            
            // This is garbage, find a cleaner way
            if let possibleView = self.createView(viewController["view"])
            {
                view = possibleView
            } else if let possibleTableView = self.createTableView(viewController["tableView"])
            {
                view = possibleTableView
            } else if let possibleCollectionView = self.createCollectionView(viewController["collectionView"])
            {
                view = possibleCollectionView
            }
            
            let viewControllerInstanceInfo = ViewControllerInstanceInfo(classInfo: viewControllerClassInfo!, id: id, storyboardIdentifier: storyboardIdentifier, view: view)
            
            sceneInfo.controller = viewControllerInstanceInfo
            self.applicationInfo.add(viewControllerInstance: viewControllerInstanceInfo)
            
            self.parseLayoutGuides(viewController["layoutGuides"], source: viewControllerInstanceInfo)
            
            let navigationItem = viewController["navigationItem"]
            if navigationItem.element != nil
            {
                self.parseNavigationItem(navigationItem, source: viewControllerInstanceInfo)
            }
            
            self.parseConnections(viewController["connections"], source: viewControllerInstanceInfo)
        }
    }
    
    // MARK: Navigation Controller
    
    internal func parseNavigationController(navigationController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = navigationController.element, let id = element.attributes["id"]
        {
            let useClass = StoryboardFile3_0Parser.useClass(element, classInfo: NavigationControllerClassInfo.self)
            
            // TODO: restrict to NavControllerClasses
            var navigationControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(useClass) as? NavigationControllerClassInfo
            if navigationControllerClassInfo == nil
            {
                navigationControllerClassInfo = NavigationControllerClassInfo(className: useClass)
                self.applicationInfo.add(viewControllerClass: navigationControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            let sceneMemberId = element.attributes["sceneMemberID"]
            
            let navigationControllerInstanceInfo = NavigationControllerInstanceInfo(classInfo: navigationControllerClassInfo!, id: id, storyboardIdentifier: storyboardIdentifier, sceneMemberId: sceneMemberId)
            
            sceneInfo.controller = navigationControllerInstanceInfo
            self.applicationInfo.add(navigationControllerInstance: navigationControllerInstanceInfo)
            
            /*            var navigationBar = viewController["navigationBar"] //TODO: can this be optional?
            if navigationBar.element != nil
            {
            self.parseNavigationBar(navigationBar, source: navigationControllerInstanceInfo)
            }
            */
            self.parseConnections(navigationController["connections"], source: navigationControllerInstanceInfo)
        }
    }
    
    // MARK: Tab Bar Controller
    
    internal func parseTabBarController(viewController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = viewController.element,
            let id = element.attributes["id"]
        {
            let useClass = StoryboardFile3_0Parser.useClass(element, classInfo: TabBarControllerClassInfo.self)
            
            let classInfo = self.findOrCreateViewControllerClassInfo(useClass, classInfo: TabBarControllerClassInfo.self)
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            
            let view = self.createView(viewController["view"]) // Should be using view.key attribute?
            
            let instanceInfo = TabBarControllerInstanceInfo(classInfo: classInfo, id: id, storyboardIdentifier: storyboardIdentifier, view: view)
            
            sceneInfo.controller = instanceInfo
            self.applicationInfo.add(tabBarControllerInstance: instanceInfo)
            
            self.parseLayoutGuides(viewController["layoutGuides"], source: instanceInfo)
            
            let navigationItem = viewController["navigationItem"]
            if navigationItem.element != nil
            {
                self.parseNavigationItem(navigationItem, source: instanceInfo)
            }
            
            self.parseConnections(viewController["connections"], source: instanceInfo)
        }
    }
    
    // MARK: Layout Guides
    
    internal func parseLayoutGuides(layoutGuides : XMLIndexer, source : ViewControllerInstanceInfo) {
        for layoutGuide in layoutGuides.children
        {
            self.parseLayoutGuide(layoutGuide, source: source)
        }
    }
    
    internal func parseLayoutGuide(layoutGuide : XMLIndexer, source : ViewControllerInstanceInfo) {
        
        if let element = layoutGuide.element,
            let id = element.attributes["id"],
            let type = element.attributes["type"]
        {
            let layoutGuide = ViewControllerLayoutGuideInstanceInfo(id: id, type: type )
            source.add(layoutGuide: layoutGuide)
        } else
        {
            self.Log("Unable to create View Controller Layout Guide Instance Info from \(layoutGuide)")
        }
    }
    
    // MARK: Navigation Item
    
    internal func parseNavigationItem(navigationItem : XMLIndexer, source : ViewControllerInstanceInfo) {
        
        switch navigationItem
        {
        case .Element(let element):
            if let id = element.attributes["id"],
                let navigationItemKey = element.attributes["key"],
                let title = element.attributes["title"]
            {
                let navigationItemInstance = NavigationItemInstanceInfo(id: id, navigationItemKey: navigationItemKey, title: title)
                source.add(navigationItem: navigationItemInstance)
            } else
            {
                self.Log("Unable to create Navigation Item Instance Info from \(navigationItem)")
            }
            break
        case .XMLError(let error):
            self.Log("Unable to create Navigation Item Instance Info from \(navigationItem): \(error)")
            break
        default:
            self.Log("Unable to create Navigation Item Instance Info from \(navigationItem), unhandled element \(navigationItem.element)")
        }
    }
    
    // MARK: Connections
    
    internal func parseConnection(connection : XMLIndexer, source : ViewControllerInstanceInfo) {
        if let element = connection.element
        {
            if element.name == "segue"
            {
                if let segueParseInfo = self.createConnectionParseInfo(connection, source: source )
                {
                    self.parsedSegues.append(segueParseInfo)
                }
            } else
            {
                self.Log("Skipping unsupported connection type \(element.name)")
            }
        }
    }
    
    internal func parseConnections(connections : XMLIndexer, source : ViewControllerInstanceInfo) {
        for connection in connections.children
        {
            self.parseConnection(connection, source: source)
        }
    }
}