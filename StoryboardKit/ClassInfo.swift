//
//  ClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

/// Represents a Class
public class ClassInfo: NSObject {
    public class var defaultClass : String { return "" }

    /// Name of the Class
    public let infoClassName : String
    
    /**
     Default init
     
     - parameter className: name of the Class. If nil defaults to ClassInfo.defaultClass.
     
     - returns: A new ClassInfo instance
     */
    required public init(className : String?) {
        
        var useClassName : String
        if className != nil
        {
            useClassName = className!
        } else
        {
            useClassName = self.dynamicType.defaultClass
        }
        
        self.infoClassName = useClassName
        
        super.init()
    }
}

extension ClassInfo /*: CustomDebugStringConvertible*/ {
    
    /// Debug Description
    public override var debugDescription: String {
        var result = super.debugDescription
        
        result += "Class: \(self.infoClassName)"
        
        return result
    }
}