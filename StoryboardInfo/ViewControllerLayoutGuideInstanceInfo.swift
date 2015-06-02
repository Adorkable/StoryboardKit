//
//  ViewControllerLayoutGuideInstanceInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 6/1/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class ViewControllerLayoutGuideInstanceInfo: NSObject {
    public let id : String
    public let type : String
    
    init(id : String, type : String) {
        self.id = id
        self.type = type
    }
}
