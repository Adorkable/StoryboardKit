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
    public let useAutolayout : Bool
    public let useTraitCollections : Bool
    public let initialViewController : ViewControllerInstanceInfo?
    
    /// All scenes in the storyboard
    public private(set) var scenes = Array<SceneInfo>()
    
    public required init(useAutolayout : Bool, useTraitCollections : Bool, initialViewController : ViewControllerInstanceInfo?) {
        
        self.useAutolayout = useAutolayout
        self.useTraitCollections = useTraitCollections
        self.initialViewController = initialViewController
        
        super.init()
    }
    
    /**
    *  Represents a Scene in the storyboard
    */
    public class SceneInfo: NSObject {
        let sceneId : String
        
        // TODO: not optional, use parsing placeholder
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
