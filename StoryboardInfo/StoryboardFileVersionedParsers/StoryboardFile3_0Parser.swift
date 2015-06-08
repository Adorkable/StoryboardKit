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
    
    required init(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo)
    {
        self.applicationInfo = applicationInfo
        self.storyboardInfo = storyboardInfo
        
        super.init()
    }

    func parse(indexer : XMLIndexer) -> NSError? {
        var result : NSError?
        
        self.parseScenes(indexer["document"]["scenes"])
        
        self.createSegueInstanceInfosFromParsed()
        
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
                viewControllerClassInfo = ViewControllerClassInfo(className: customClass)
                self.applicationInfo.add(viewControllerClass: viewControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            var viewControllerInstanceInfo = ViewControllerInstanceInfo(classInfo: viewControllerClassInfo!, id: id, storyboardIdentifier: storyboardIdentifier)
            
            sceneInfo.controller = viewControllerInstanceInfo
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
    
    internal class SegueInstanceParseInfo : NSObject {
        internal let classInfo : SegueClassInfo
        internal let id : String
        internal var source : SegueConnection
        internal let kind : String?
        internal let identifier : String?
        internal let destinationId : String
        internal var destination : SegueConnection?
        
        init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destinationId : String, kind : String?, identifier : String?) {
            self.classInfo = classInfo
            self.id = id
            self.source = source
            self.destinationId = destinationId
            self.kind = kind
            self.identifier = identifier
            
            super.init()
        }
    }
    
    internal func createConnectionParseInfo(connection : XMLIndexer, source : ViewControllerInstanceInfo) -> SegueInstanceParseInfo? {
        var result : SegueInstanceParseInfo?
        
        if let element = connection.element,
            let id = element.attributes["id"],
            let destinationId = element.attributes["destination"]
        {
            let customClass = element.attributes["customClass"]
            var segueClass = self.applicationInfo.segueClassWithClassName(customClass)
            if segueClass == nil
            {
                segueClass = SegueClassInfo(className: customClass)
                self.applicationInfo.add(segueClass: segueClass!)
            }
            
            let kind = element.attributes["kind"]
            let identifier = element.attributes["identifier"]
            
            result = SegueInstanceParseInfo(classInfo: segueClass!, id: id, source: StoryboardInfo_WeakWrapper(source), destinationId: destinationId, kind: kind, identifier: identifier)
        }
        
        return result
    }
    
    var parsedSegues = Array<SegueInstanceParseInfo>()
    
    internal func parseConnection(connection : XMLIndexer, source : ViewControllerInstanceInfo) {
        if let segueParseInfo = self.createConnectionParseInfo(connection, source: source )
        {
            self.parsedSegues.append(segueParseInfo)
        }
    }
    
    internal func parseConnections(connections : XMLIndexer, source : ViewControllerInstanceInfo) {
        for connection in connections.children
        {
            self.parseConnection(connection, source: source)
        }
    }
    
    internal func parseNavigationController(navigationController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = navigationController.element, let id = element.attributes["id"]
        {
             // TODO: test
            let customClass = element.attributes["customClass"]
            // TODO: restrict to NavControllerClasses
            var navigationControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(customClass) as? NavigationControllerClassInfo
            if navigationControllerClassInfo == nil
            {
                navigationControllerClassInfo = NavigationControllerClassInfo(className: customClass)
                self.applicationInfo.add(viewControllerClass: navigationControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            let sceneMemberId = element.attributes["sceneMemberID"]
            
            var navigationControllerInstanceInfo = NavigationControllerInstanceInfo(classInfo: navigationControllerClassInfo!, id: id, storyboardIdentifier: storyboardIdentifier, sceneMemberId: sceneMemberId)
            
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
    
    internal func createSegueInstanceInfosFromParsed() {
        while self.parsedSegues.count > 0
        {
            var segueParsedInfo = self.parsedSegues.removeLast()

            var segueInfo : SegueInstanceInfo?

            if let destination = self.applicationInfo.viewControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else if let destination = self.applicationInfo.navigationControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else
            {
                NSLog("Error linking pending segues, unable to find destination with id \(segueParsedInfo.destinationId)")
            }
            
            if segueInfo != nil {
                if segueInfo!.kind == "relationship" && segueInfo!.source.value is NavigationControllerInstanceInfo {
                    (segueInfo!.source.value as! NavigationControllerInstanceInfo).root = segueInfo
                } else {
                    segueInfo!.source.value!.add(segue: segueInfo!)
                }
            }
        }
    }
}
