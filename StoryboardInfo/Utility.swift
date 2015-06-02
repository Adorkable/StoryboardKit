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

enum StoryboardInfo_Either<TLeft : AnyObject, TRight : AnyObject> {
    case Left(TLeft)
    case Right(TRight)
}

// http://stackoverflow.com/a/24102282
class StoryboardInfo_Weak<T : AnyObject> {
    unowned let value: T
    
    init(_ value: T) {
        self.value = value
    }
}