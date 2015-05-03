//
//  SegueClassInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/4/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class SegueClassInfo: NSObject {
    let customClass : String?
    static let defaultClass = "UIStoryboardSegue"
    
    var instanceInfos = Array< StoryboardInfo_WeakWrapper< SegueInstanceInfo> >()
    
    init(customClass : String?) {
        self.customClass = customClass
        
        super.init()
    }
}