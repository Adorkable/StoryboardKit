//
//  StoryboardInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

/**
*  Represents a Storyboard file instance
*/
public class StoryboardInstanceInfo: NSObject {
    /// All scenes in the storyboard
    public private(set) var scenes = Array<SceneInfo>()
    
    /**
    *  Represents a Scene in the storyboard
    */
    public class SceneInfo: NSObject {
        let sceneId : String
        
        public var controller : ViewControllerInstanceInfo?
        
        public var placeHolder : AnyObject?
        
        init(sceneId : String) {
            self.sceneId = sceneId
            
            super.init()
        }
    }

    /**
    Add a Scene to the storyboard
    
    :param: scene Scene to add
    */
    func add(#scene : SceneInfo) {
        // TODO: validate that it isn't a dup
        self.scenes.append(scene)
    }
}
