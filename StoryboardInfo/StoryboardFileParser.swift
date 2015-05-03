//
//  StoryboardFileParser.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

public class StoryboardFileParser: NSObject {
    public class func parse(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo, pathFileName : String) {
        StoryboardFileParser(applicationInfo: applicationInfo, storyboardInfo: storyboardInfo, pathFileName: pathFileName)
    }
    
    let applicationInfo : ApplicationInfo
    let storyboardInfo : StoryboardInstanceInfo
    var pendingSegues = Array<SegueInstanceInfo>()

    internal init(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo, pathFileName : String) {
        self.applicationInfo = applicationInfo
        self.storyboardInfo = storyboardInfo
        
        super.init()

        self.parse(pathFileName)
    }
    
    internal func parse(pathFileName : String) {
        if NSFileManager.defaultManager().fileExistsAtPath(pathFileName) {
            if let data = NSData(contentsOfFile: pathFileName)
            {
                let indexer = SWXMLHash.parse(data)
                var result = self.parseXML(indexer)
                
                if result != nil
                {
                    NSLog("Error: when parsing \(result)")
                }
            }
        }
    }
    
    internal func parseXML(indexer : XMLIndexer) -> NSError? {
        var result : NSError?
        
        var version = StoryboardFileParser.getVersion(indexer)
        if version == "3.0"
        {
            result = self.parse3_0(indexer)
        } else
        {
            result = NSError(domain: "Unsupported version: \(version)", code: 0, userInfo: nil)
        }
        
        return result
    }
    
    internal class func getVersion(indexer : XMLIndexer) -> String? {
        return indexer["document"].element?.attributes["version"];
    }
    
    // FUTURE: separate out versioned parsers
    internal func parse3_0(indexer : XMLIndexer) -> NSError? {
        var result : NSError?
        
        self.parse3_0_scenes(indexer["document"]["scenes"])
        
        self.linkPendingSegues()
        
        return result
    }
    
    internal func parse3_0_scenes(scenes : XMLIndexer) {
        for scene in scenes.children {

            self.parse3_0_individualScene(scene)
        }
    }
    
    internal func parse3_0_individualScene(scene : XMLIndexer) {

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
                        self.parse3_0_viewController(object, sceneInfo: sceneInfo)
                    } else
                    {
                        NSLog("Skipping unsupported scene object \(sceneObjectElement.name)")
                    }
                }
            }
        }
    }
    
    internal func parse3_0_viewController(viewController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
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
                self.parse3_0_connection(connection, source: viewControllerInstanceInfo)
            }
        }
    }
    
    internal func parse3_0_connection(connection : XMLIndexer, source : ViewControllerInstanceInfo) {
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
