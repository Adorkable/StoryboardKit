//
//  Utility.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

// http://stackoverflow.com/a/24128121/96153
class StoryboardInfo_WeakWrapper<T: AnyObject> {
    weak var value : T?
    init (value: T) {
        self.value = value
    }
}