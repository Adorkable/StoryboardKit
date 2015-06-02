//
//  StoryboardFile3_0Parser.swift
//  StoryboardInfo
//
//  Created by Ian on 5/31/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

class StoryboardFile3_0Parser: NSObject, StoryboardFileVersionedParser {
    let applicationInfo : ApplicationInfo
    let storyboardInfo : StoryboardInstanceInfo
    var pendingSegues = Array<SegueInstanceInfo>()
    
    required init(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo)
    {
        self.applicationInfo = applicationInfo
        self.storyboardInfo = storyboardInfo
        
        super.init()
    }

    func parse(indexer : XMLIndexer) -> NSError? {
        var result : NSError?
        
        self.parseScenes(indexer["document"]["scenes"])
        
        self.linkPendingSegues()
        
        return result
    }
    
    internal func parseScenes(scenes : XMLIndexer) {
        for scene in scenes.children {
            
            self.parseIndividualScene(scene)
        }
    }
    
    internal func parseIndividualScene(scene : XMLIndexer) {
        
        if let element = scene.element, let sceneId = element.attributes["sceneID"]
        {
            var sceneInfo = StoryboardInstanceInfo.SceneInfo(sceneId: sceneId)
            self.storyboardInfo.add(scene: sceneInfo)
            
            var objects = scene["objects"]
            for object in objects.children {
                if let sceneObjectElement = object.element
                {
                    if sceneObjectElement.name == "viewController" || sceneObjectElement.name == "tableViewController"
                    {
                        self.parseViewController(object, sceneInfo: sceneInfo)
                    } else if sceneObjectElement.name == "navigationController"
                    {
                        self.parseNavigationController(object, sceneInfo: sceneInfo)
                    } else
                    {
                        // TODO: placeholder
                        NSLog("Skipping unsupported scene object \(sceneObjectElement.name)")
                    }
                }
            }
        }
    }
    
    internal func parseViewController(viewController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = viewController.element, let id = element.attributes["id"]
        {
            let customClass = element.attributes["customClass"]
            var viewControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(customClass)
            if viewControllerClassInfo == nil
            {
                viewControllerClassInfo = ViewControllerClassInfo(customClass: customClass)
                self.applicationInfo.add(viewControllerClass: viewControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            var viewControllerInstanceInfo = ViewControllerInstanceInfo(classInfo: viewControllerClassInfo!, id: id, storyboardIdentifier: storyboardIdentifier)
            
            sceneInfo.viewController = viewControllerInstanceInfo
            self.applicationInfo.add(viewControllerInstance: viewControllerInstanceInfo)
            
            self.parseLayoutGuides(viewController["layoutGuides"], source: viewControllerInstanceInfo)
            self.parseView(viewController["view"], source: viewControllerInstanceInfo)
            
            var navigationItem = viewController["navigationItem"]
            if navigationItem.element != nil
            {
                self.parseNavigationItem(navigationItem, source: viewControllerInstanceInfo)
            }
            
            self.parseConnections(viewController["connections"], source: viewControllerInstanceInfo)
        }
    }
    
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
            var layoutGuide = ViewControllerLayoutGuideInstanceInfo(id: id, type: type )
            source.add(layoutGuide: layoutGuide)
        } else
        {
            NSLog("Unable to create View Controller Layout Guide Instance Info from \(layoutGuide)")
        }
    }
    
    internal func parseView(view : XMLIndexer, source : ViewControllerInstanceInfo) {
        // TODO: View Tree parsing
    }
    
    internal func parseNavigationItem(navigationItem : XMLIndexer, source : ViewControllerInstanceInfo) {
        
        switch navigationItem
        {
        case .Element(let element):
                if let element = navigationItem.element,
                    let id = element.attributes["id"],
                    let navigationItemKey = element.attributes["key"],
                    let title = element.attributes["title"]
                {
                    var navigationItem = NavigationItemInstanceInfo(id: id, navigationItemKey: navigationItemKey, title: title)
                    source.add(navigationItem: navigationItem)
                } else
                {
                    NSLog("Unable to create Navigation Item Instance Info from \(navigationItem)")
                }
            break
        case .Error(let error):
                NSLog("Unable to create Navigation Item Instance Info from \(navigationItem): \(error)")
            break
        default:
            NSLog("Unable to create Navigation Item Instance Info from \(navigationItem), unhandled element \(navigationItem.element)")
        }
    }
    
    internal func createConnection(connection : XMLIndexer, source : SegueConnection) -> SegueInstanceInfo? {
        var result : SegueInstanceInfo?
        
        if let element = connection.element,
            let id = element.attributes["id"],
            let destinationId = element.attributes["destination"]
        {
            let customClass = element.attributes["customClass"]
            var segueClass = self.applicationInfo.segueClassWithClassName(customClass)
            if segueClass == nil
            {
                segueClass = SegueClassInfo(customClass: customClass)
                self.applicationInfo.add(segueClass: segueClass!)
            }
            
            let kind = element.attributes["kind"]
            let identifier = element.attributes["identifier"]
            
            result = SegueInstanceInfo(classInfo: segueClass!, id: id, source: source, destinationId: destinationId, kind: kind, identifier: identifier)
        }
        
        return result
    }
    
    internal func parseConnection(connection : XMLIndexer, source : ViewControllerInstanceInfo) {
        if let segueInfo = self.createConnection(connection, source: StoryboardInfo_Either.Left( StoryboardInfo_WeakWrapper(source) ) )
        {
            source.add(segue: segueInfo)
            
            self.pendingSegues.append(segueInfo)
        }
    }
    
    internal func parseConnections(connections : XMLIndexer, source : ViewControllerInstanceInfo) {
        for connection in connections.children
        {
            self.parseConnection(connection, source: source)
        }
    }
    
    internal func parseConnection(connection : XMLIndexer, source : NavigationControllerInstanceInfo) {
        if let segueInfo = self.createConnection(connection, source: StoryboardInfo_Either.Right( StoryboardInfo_WeakWrapper(source) ) )
        {
            source.root = segueInfo
            
            self.pendingSegues.append(segueInfo)
        }
    }
    
    internal func parseConnections(connections : XMLIndexer, source : NavigationControllerInstanceInfo) {
        for connection in connections.children
        {
            self.parseConnection(connection, source: source)
        }
    }
    
    internal func parseNavigationController(navigationController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = navigationController.element, let id = element.attributes["id"]
        {
             // TODO: test
/*            let customClass = element.attributes["customClass"]
            var viewControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(customClass)
            if viewControllerClassInfo == nil
            {
                viewControllerClassInfo = ViewControllerClassInfo(customClass: customClass)
                self.applicationInfo.add(viewControllerClass: viewControllerClassInfo!)
            }
*/
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            let sceneMemberId = element.attributes["sceneMemberID"]
            
            var navigationControllerInstanceInfo = NavigationControllerInstanceInfo(id: id, storyboardIdentifier: storyboardIdentifier, sceneMemberId: sceneMemberId)
            
            sceneInfo.navigationController = navigationControllerInstanceInfo
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
    
    internal func linkPendingSegues() {
        while self.pendingSegues.count > 0
        {
            var segueInfo = self.pendingSegues.removeLast()

            if let destination = self.applicationInfo.viewControllerInstanceWithId(segueInfo.destinationId)
            {
                // TODO: lame to have destination optional as a side effect of parsing process, FIX
                segueInfo.destination = StoryboardInfo_Either.Left( StoryboardInfo_WeakWrapper(destination) )
            } else if let destination = self.applicationInfo.navigationControllerInstanceWithId(segueInfo.destinationId)
            {
                segueInfo.destination = StoryboardInfo_Either.Right( StoryboardInfo_WeakWrapper(destination) )
            } else
            {
                NSLog("Error linking pending segues, unable to find destination with id \(segueInfo.destinationId)")
            }
        }
    }
}
