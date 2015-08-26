//
//  StoryboardFile3_0Parser_Segues.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

extension StoryboardFile3_0Parser {
    // MARK: Segues
    
    internal class SegueInstanceParseInfo : NSObject, DebugPrintable {
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
            let id = element.attributes["id"],
            let destinationId = element.attributes["destination"]
        {
            var useClass : String
            if let customClass = element.attributes["customClass"]
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
            
            let kind = element.attributes["kind"]
            let identifier = element.attributes["identifier"]
            
            result = SegueInstanceParseInfo(classInfo: segueClass!, id: id, source: StoryboardKit_WeakWrapper(source), destinationId: destinationId, kind: kind, identifier: identifier)
        }
        
        return result
    }
    
    internal func parseConnection(connection : XMLIndexer, source : ViewControllerInstanceInfo) {
        if let segueParseInfo = self.createConnectionParseInfo(connection, source: source )
        {
            self.parsedSegues.append(segueParseInfo)
        }
    }
    
    internal func parseConnections(connections : XMLIndexer, source : ViewControllerInstanceInfo) {
        for connection in connections.children
        {
            self.parseConnection(connection, source: source)
        }
    }
    
    internal func createSegueInstanceInfosFromParsed() {
        while self.parsedSegues.count > 0
        {
            var segueParsedInfo = self.parsedSegues.removeLast()
            
            var segueInfo : SegueInstanceInfo?
            
            if let destination = self.applicationInfo.viewControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else if let destination = self.applicationInfo.navigationControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else
            {
                NSLog("Error linking pending segues, unable to find destination with id \(segueParsedInfo.destinationId)")
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