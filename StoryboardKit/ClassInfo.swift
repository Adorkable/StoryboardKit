//
//  ClassInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/29/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class ClassInfo: NSObject {
    public let infoClassName : String
    
    init(className : String) {
        self.infoClassName = className
        
        super.init()
    }
}

extension ClassInfo : CustomDebugStringConvertible {
    
    public override var debugDescription: String {
        get {
            var result = super.debugDescription
            
            result += "\nClass: \(self.infoClassName)"
            
            return result
        }
    }
}