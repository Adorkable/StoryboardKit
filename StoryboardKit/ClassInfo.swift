//
//  ClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class ClassInfo: NSObject {
    class var defaultClass : String { return "" }

    public let infoClassName : String
    
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

extension ClassInfo : CustomDebugStringConvertible {
    
    public override var debugDescription: String {
        var result = super.debugDescription
        
        result += "\nClass: \(self.infoClassName)"
        
        return result
    }
}