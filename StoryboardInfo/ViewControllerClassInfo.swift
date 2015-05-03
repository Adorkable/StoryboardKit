//
//  ViewControllerClassInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class ViewControllerClassInfo: NSObject {
    let customClass : String?
    static let defaultClass = "UIViewController"

    var instanceInfos = Array< StoryboardInfo_WeakWrapper<ViewControllerInstanceInfo> >()
    
    init(customClass : String?) {
        self.customClass = customClass
        
        super.init()
    }
}
