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
                    } else
                    {
                        NSLog("Skipping unsupported scene object \(sceneObjectElement.name)")
                    }
                }
            }
        }
    }
    
    internal func parseViewController(viewController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = viewController.element, let instanceId = element.attributes["id"]
        {
            let customClass = element.attributes["customClass"]
            var viewControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(customClass)
            if viewControllerClassInfo == nil
            {
                viewControllerClassInfo = ViewControllerClassInfo(customClass: customClass)
                self.applicationInfo.add(viewControllerClass: viewControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            var viewControllerInstanceInfo = ViewControllerInstanceInfo(classInfo: viewControllerClassInfo!, instanceId: instanceId, storyboardIdentifier: storyboardIdentifier)
            
            sceneInfo.viewController = viewControllerInstanceInfo
            self.applicationInfo.add(viewControllerInstance: viewControllerInstanceInfo)
            
            // TODO: layoutGuides
            // TODO: view
            // TODO: navigationItem
            
            for connection in viewController["connections"].children
            {
                self.parseConnection(connection, source: viewControllerInstanceInfo)
            }
        }
    }
    
    internal func parseConnection(connection : XMLIndexer, source : ViewControllerInstanceInfo) {
        if let element = connection.element,
            let instanceId = element.attributes["id"],
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
            
            var segueInfo = SegueInstanceInfo(classInfo: segueClass!, instanceId: instanceId, source: source, destinationId: destinationId, kind: kind, identifier: identifier)
            
            source.add(segue: segueInfo)
            
            self.pendingSegues.append(segueInfo)
        }
    }
    
    internal func linkPendingSegues() {
        while self.pendingSegues.count > 0
        {
            var segueInfo = self.pendingSegues.removeLast()
            var destination = self.applicationInfo.viewControllerInstanceWithInstanceId(segueInfo.destinationId)
            if destination != nil
            {
                segueInfo.destination = destination!
            }
        }
    }
}
