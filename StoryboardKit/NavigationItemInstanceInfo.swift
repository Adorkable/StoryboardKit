//
//  NavigationItemInstanceInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/1/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class NavigationItemInstanceInfo: NSObject, Idable {
    public let id : String
    public let navigationItemKey : String
    public let title : String
    
    init(id : String, navigationItemKey : String, title : String) {
        self.id = id
        self.navigationItemKey = navigationItemKey
        self.title = title
    }
}
