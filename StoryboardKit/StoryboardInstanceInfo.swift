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
    
    /// Use Autolayout
    public let useAutolayout : Bool

    /// Use Trait Collections
    public let useTraitCollections : Bool
    
    /// Initial View Controller Instance
    public let initialViewController : ViewControllerInstanceInfo?
    
    /// All scenes in the storyboard
    public private(set) var scenes = Array<SceneInfo>()
    
    /**
     Default init
     
     - parameter useAutolayout:         Use Autolayout
     - parameter useTraitCollections:   Use Trait Collections
     - parameter initialViewController: Initial View Controller Instance
     
     - returns: A new instance.
     */
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
        
        /// Scene Id
        let sceneId : String
        
        // TODO: not optional, use parsing placeholder
        /// View Controller
        public var controller : ViewControllerInstanceInfo?
        
        /// Placeholder object
        public var placeHolder : AnyObject?
        
        /**
         Default init
         
         - parameter sceneId: Scene Id
         
         - returns: A new instance.
         */
        init(sceneId : String) {
            self.sceneId = sceneId
            
            super.init()
        }
    }

    /**
    Add a Scene to the storyboard
    
    - parameter scene: Scene to add
    */
    func add(scene scene : SceneInfo) {
        // TODO: validate that it isn't a dup
        self.scenes.append(scene)
    }
}
