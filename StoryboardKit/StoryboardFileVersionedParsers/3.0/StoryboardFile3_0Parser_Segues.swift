//
//  StoryboardFile3_0Parser_Segues.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

internal extension StoryboardFile3_0Parser {
    // MARK: Segues
    
    internal class SegueInstanceParseInfo : NSObject/*, CustomDebugStringConvertible*/ {
        internal let classInfo : SegueClassInfo
        internal let id : String
        internal var source : SegueConnection
        internal let kind : String?
        internal let identifier : String?
        internal let destinationId : String
        internal var destination : SegueConnection?
        
        init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destinationId : String, kind : String?, identifier : String?) {
            self.classInfo = classInfo
            self.id = id
            self.source = source
            self.destinationId = destinationId
            self.kind = kind
            self.identifier = identifier
            
            super.init()
        }
        
        override var debugDescription : String {
            var result : String = super.debugDescription
            
            if let identifier = self.identifier
            {
                result += identifier
            }
            
            return result
        }
    }
    
    internal func createConnectionParseInfo(connection : XMLIndexer, source : ViewControllerInstanceInfo) -> SegueInstanceParseInfo? {
        var result : SegueInstanceParseInfo?
        
        if let element = connection.element,
            let id = element.allAttributes["id"]?.text,
            let destinationId = element.allAttributes["destination"]?.text
        {
            var useClass : String
            if let customClass = element.allAttributes["customClass"]?.text
            {
                useClass = customClass
            } else
            {
                useClass = SegueClassInfo.defaultClass
            }
            
            var segueClass = self.applicationInfo.segueClassWithClassName(useClass)
            if segueClass == nil
            {
                segueClass = SegueClassInfo(className: useClass)
                self.applicationInfo.add(segueClass: segueClass!)
            }
            
            let kind = element.allAttributes["kind"]?.text
            let identifier = element.allAttributes["identifier"]?.text
            
            result = SegueInstanceParseInfo(classInfo: segueClass!, id: id, source: StoryboardKit_WeakWrapper(source), destinationId: destinationId, kind: kind, identifier: identifier)
        }
        
        return result
    }
    
    internal func createSegueInstanceInfosFromParsed() {
        while self.parsedSegues.count > 0
        {
            let segueParsedInfo = self.parsedSegues.removeLast()
            
            var segueInfo : SegueInstanceInfo?
            
            if let destination = self.applicationInfo.viewControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else if let destination = self.applicationInfo.navigationControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else if let destination = self.applicationInfo.tabBarControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else
            {
                self.Log("Error linking pending segues, unable to find destination with id \(segueParsedInfo.destinationId)")
            }
            
            if segueInfo != nil {
                if segueInfo!.kind == "relationship" && segueInfo!.source.value is NavigationControllerInstanceInfo {
                    (segueInfo!.source.value as! NavigationControllerInstanceInfo).root = segueInfo
                } else {
                    segueInfo!.source.value!.add(segue: segueInfo!)
                }
            }
        }
    }
}