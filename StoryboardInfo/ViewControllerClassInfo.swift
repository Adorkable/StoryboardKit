//
//  ViewControllerClassInfo.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

public class ViewControllerClassInfo: NSObject {
    public let customClass : String?
    public static let defaultClass = "UIViewController"

    public private(set) var instanceInfos = Array< StoryboardInfo_WeakWrapper<ViewControllerInstanceInfo> >()
    
    init(customClass : String?) {
        self.customClass = customClass
        
        super.init()
    }
    
    func add(#instanceInfo : ViewControllerInstanceInfo) {
        self.instanceInfos.append( StoryboardInfo_WeakWrapper(instanceInfo) )
    }
}
