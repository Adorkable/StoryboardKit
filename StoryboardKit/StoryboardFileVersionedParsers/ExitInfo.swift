//
//  ExitInfo.swift
//  StoryboardKit
//
//  Created by Иван Ушаков on 04.03.16.
//  Copyright © 2016 Adorkable. All rights reserved.
//

import Foundation

// TODO: should we keep it weak? should we be using the weak attribute?
public typealias SceneConnection = StoryboardKit_WeakWrapper<StoryboardInstanceInfo.SceneInfo>

public class ExitInfo: NSObject, Idable {
    
    /// Storyboard Id
    public let id : String
    
    // Connection
    public let connection : SceneConnection;
    
    public init(id : String, connection : SceneConnection) {
        self.id = id
        self.connection = connection
        
        super.init()
    }
    
    public convenience init(id : String, connection : StoryboardInstanceInfo.SceneInfo) {
        self.init(id: id, connection: SceneConnection(connection))
    }
}

extension ExitInfo /*: CustomDebugStringConvertible*/ {
    
    /// Debug Description
    override public var debugDescription : String {
        get {
            var result = super.debugDescription
            
            result += "\nId: \(self.id)"
            result += "\nConnection: \(self.connection)"
            
            return result
        }
    }
}