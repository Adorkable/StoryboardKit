//
//  Utility.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

// TODO: organize appropriately, evaulate need of each

// http://stackoverflow.com/a/24128121/96153
public class StoryboardKit_WeakWrapper<T: AnyObject> {
    weak var value : T?
    init (_ value: T) {
        self.value = value
    }
}

public enum StoryboardKit_Either<TLeft : AnyObject, TRight : AnyObject> {
    case Left(TLeft)
    case Right(TRight)
}

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