//
//  StoryboardFile3_0Parser_Storyboard.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

internal extension StoryboardFile3_0Parser {
    
    
    // MARK: Storyboard
    
    internal class StoryboardInstanceParseInfo : NSObject {
        //        internal var fileType : String
        //        internal var fileVersion : String
        //        internal var toolsVersion : String
        //        internal var systemVersion : String
        //        internal var targetRuntime : String
        //        internal var propertyAccessControl : String
        
        internal var useAutolayout : Bool
        internal var useTraitCollections : Bool
        internal var initialViewControllerId : String?
        
        init(useAutolayout : Bool, useTraitCollections : Bool, initialViewControllerId : String?) {
            self.useAutolayout = useAutolayout
            self.useTraitCollections = useTraitCollections
            self.initialViewControllerId = initialViewControllerId
            
            super.init()
        }
        
        var scenes : [StoryboardInstanceInfo.SceneInfo] = Array<StoryboardInstanceInfo.SceneInfo>()
        
        func add(scene scene : StoryboardInstanceInfo.SceneInfo) {
            // TODO: validate that it isn't a dup
            self.scenes.append(scene)
        }
    }
    
    internal func createStoryboardInstance(root : XMLIndexer) -> StoryboardInstanceParseInfo? {
        var result : StoryboardInstanceParseInfo?
        
        if let document = root["document"].element
        {
            let useAutolayout = document.allAttributes["useAutolayout"]?.text == "YES"
            let useTraitCollections = document.allAttributes["useTraitCollections"]?.text == "YES"
            
            let initialViewControllerId = document.allAttributes["initialViewController"]?.text
            
            
            let storyboardInstance = StoryboardInstanceParseInfo(useAutolayout: useAutolayout, useTraitCollections: useTraitCollections, initialViewControllerId: initialViewControllerId)
            
            // TODO: StoryboardFileInfo
            //            storyboardInstance.fileType = document.attributes["type"]
            //            storyboardInstance.fileVersion = document.attributes["version"]
            //            storyboardInstance.toolsVersion = document.attributes["toolsVersion"]
            //            storyboardInstance.systemVersion = document.attributes["systemVersion"]
            //            storyboardInstance.targetRuntime = document.attributes["targetRuntime"]
            //            storyboardInstance.propertyAccessControl = document.attributes["propertyAccessControl"]
            
            result = storyboardInstance
        }
        
        return result
    }
    
    internal func createStoryboardInstanceInfoFromParsed() throws -> StoryboardFileParser.ParseResult {
        var result : StoryboardFileParser.ParseResult
        
        if let storyboardInstanceParseInfo = self.storyboardInstanceParseInfo
        {
            var initialViewController : ViewControllerInstanceInfo?
            
            if let initialViewControllerId = storyboardInstanceParseInfo.initialViewControllerId
            {
                initialViewController = self.applicationInfo.viewControllerInstanceWithId(initialViewControllerId)
            }
            
            let storyboardInstanceInfo = StoryboardInstanceInfo(useAutolayout: storyboardInstanceParseInfo.useAutolayout, useTraitCollections: storyboardInstanceParseInfo.useTraitCollections, initialViewController: initialViewController)
            
            for sceneInfo in storyboardInstanceParseInfo.scenes
            {
                storyboardInstanceInfo.add(scene: sceneInfo)
            }
            
            result = (storyboardInstanceInfo, self.logs)
        } else
        {
            throw NSError(domain: "Unable to find StoryboardInstanceParseInfo, likely cause was we were unable to parse root of Storyboard file", code: 0, userInfo: nil)
        }
        
        return result
    }
}