//
//  SegueInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

// TODO: should we keep it weak? should we be using the weak attribute?
public typealias SegueConnection = StoryboardKit_WeakWrapper<ViewControllerInstanceInfo>

/// Represents a Segue Instance used in your application and its storyboards
public class SegueInstanceInfo: NSObject, Idable {
    
    /// Class
    public let classInfo : SegueClassInfo
    
    /// Storyboard Id
    public let id : String
    
    /// Source
    public let source : SegueConnection
    
    /// Destination
    public let destination : SegueConnection
    
    /// Kind of Segue
    public let kind : String?
    
    /// Identifier
    public let identifier : String?
    
    /**
     Default init
     
     - parameter classInfo:   Class
     - parameter id:          Storyboard Id
     - parameter source:      Source
     - parameter destination: Destination
     - parameter kind:        Kind of Segue
     - parameter identifier:  Identifier
     
     - returns: A new instance.
     */
    public init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destination : SegueConnection, kind : String?, identifier : String?) {
        self.classInfo = classInfo
        self.id = id
        self.source = source
        self.destination = destination
        self.kind = kind
        self.identifier = identifier
        
        super.init()
        
        self.classInfo.add(instanceInfo: self)
    }

    /**
     Convenience init: Destination as a View Controller Instance
     
     - parameter classInfo:   Class
     - parameter id:          Storyboard Id
     - parameter source:      Source as SegueConnection
     - parameter destination: Destination as View Controller Instance
     - parameter kind:        Kind of Segue
     - parameter identifier:  Identifier
     
     - returns: A new instance.
     */
    public convenience init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destination : ViewControllerInstanceInfo, kind : String?, identifier : String?) {
        self.init(classInfo: classInfo, id: id, source: source, destination: StoryboardKit_WeakWrapper(destination), kind: kind, identifier: identifier)
    }
}

extension SegueInstanceInfo /*: CustomDebugStringConvertible*/ {
    
    /// Debug Description
    override public var debugDescription : String {
        get {
            var result = super.debugDescription
            
            result += "\n\(self.classInfo)"
            result += "\nId: \(self.id)"
            result += "\nSource: \(self.source.value)"
            result += "\nDestination: \(self.destination.value)"
            result += "\nKind: \(self.kind)"
            result += "\nIdentifier: \(self.identifier)"
            
            return result
        }
    }
}