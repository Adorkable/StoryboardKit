//
//  StoryboardInstanceInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

public class StoryboardInstanceInfo: NSObject {
    public private(set) var scenes = Array<SceneInfo>()
    
    public class SceneInfo: NSObject {
        let sceneId : String
        
        // TODO: can only have one or the other
        var viewController : ViewControllerInstanceInfo?
        var navigationController : NavigationControllerInstanceInfo?
        
        var placeHolder : AnyObject?
        
        init(sceneId : String) {
            self.sceneId = sceneId
            
            super.init()
        }
    }
    
    // TODO: validate that it isn't a dup
    func add(#scene : SceneInfo) {
        self.scenes.append(scene)
    }
}
