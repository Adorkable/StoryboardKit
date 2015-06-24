//
//  StoryboardInfo.swift
//  StoryboardKit
//
//  Created by Ian on 6/2/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

protocol Idable {
    var id : String { get }
}

func objectsWithId<T : Idable>(id : String, objects : [T]) -> [T] {
    return objects.filter({ $0.id == id })
}

func firstObject<T>(objects : [T]) -> T? {
    var result : T?
    
    if objects.count > 0 {
        result = objects[0]
    }
    
    return result
}

func firstObjectWithId<T : Idable>(id : String, objects : [T]) -> T? {
    return firstObject( objectsWithId(id, objects) )
}