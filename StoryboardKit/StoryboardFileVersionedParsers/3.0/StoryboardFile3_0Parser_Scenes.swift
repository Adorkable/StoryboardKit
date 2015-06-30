//
//  StoryboardFile3_0Parser_Scenes.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

extension StoryboardFile3_0Parser {
    // MARK: Scenes
    
    internal func parseScenes(scenes : XMLIndexer, storyboardInstanceParseInfo : StoryboardInstanceParseInfo) {
        for scene in scenes.children {
            
            self.parseIndividualScene(scene, storyboardInstanceParseInfo: storyboardInstanceParseInfo)
        }
    }
    
    internal func parseIndividualScene(scene : XMLIndexer, storyboardInstanceParseInfo : StoryboardInstanceParseInfo) {
        
        if let element = scene.element, let sceneId = element.attributes["sceneID"]
        {
            var sceneInfo = StoryboardInstanceInfo.SceneInfo(sceneId: sceneId)
            storyboardInstanceParseInfo.add(scene: sceneInfo)
            
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
}