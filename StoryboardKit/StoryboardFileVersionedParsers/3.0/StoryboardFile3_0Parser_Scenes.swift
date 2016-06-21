//
//  StoryboardFile3_0Parser_Scenes.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

internal extension StoryboardFile3_0Parser {
    // MARK: Scenes
    
    internal func parseScenes(scenes : XMLIndexer, storyboardInstanceParseInfo : StoryboardInstanceParseInfo) {
        for scene in scenes.children {
            
            self.parseIndividualScene(scene, storyboardInstanceParseInfo: storyboardInstanceParseInfo)
        }
    }
    
    internal func parseIndividualScene(scene : XMLIndexer, storyboardInstanceParseInfo : StoryboardInstanceParseInfo) {
        
        if let element = scene.element, let sceneId = element.attributes["sceneID"]
        {
            let sceneInfo = StoryboardInstanceInfo.SceneInfo(sceneId: sceneId)
            storyboardInstanceParseInfo.add(scene: sceneInfo)
            
            let objects = scene["objects"]
            for object in objects.children {
                if let sceneObjectElement = object.element
                {
                    if sceneObjectElement.name == "viewController" || sceneObjectElement.name == "tableViewController" || sceneObjectElement.name == "collectionViewController"
                    {
                        // TODO: seperate out VC, TVC, CVC?
                        self.parseViewController(object, sceneInfo: sceneInfo)
                    }
                    else if sceneObjectElement.name == "navigationController"
                    {
                        self.parseNavigationController(object, sceneInfo: sceneInfo)
                    }
                    else if sceneObjectElement.name == "tabBarController"
                    {
                        self.parseTabBarController(object, sceneInfo: sceneInfo)
                    }
                    else if sceneObjectElement.name == "exit"
                    {
                        self.parseExit(object, sceneInfo: sceneInfo)
                    }
                    else
                    {
                        // TODO: placeholder
                        self.Log("Skipping unsupported scene object \(sceneObjectElement.name)")
                    }
                }
            }
        }
    }
    
    internal func parseExit(exit : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = exit.element, let exitId = element.attributes["id"] {
            let exitInfo = ExitInfo(id: exitId, connection: sceneInfo)
            sceneInfo.exit = exitInfo
            self.applicationInfo.add(exit: exitInfo)
        }
    }
}