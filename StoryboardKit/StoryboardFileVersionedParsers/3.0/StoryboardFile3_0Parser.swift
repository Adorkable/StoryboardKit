//
//  StoryboardFile3_0Parser.swift
//  StoryboardKit
//
//  Created by Ian on 5/31/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

/// Parser for Storyboard File Format 3.0
internal class StoryboardFile3_0Parser: NSObject, StoryboardFileVersionedParser {
    
    static func supports(root: XMLIndexer) -> Bool {
        var result : Bool
        
        if let version = root["document"].element?.allAttributes["version"]?.text
        {
            if version == "3.0"
            {
                result = true
            } else
            {
                result = false
            }
        } else
        {
            result = false
        }
        
        return result
    }
    
    static func parse(indexer: XMLIndexer, applicationInfo: ApplicationInfo) throws -> StoryboardFileParser.ParseResult {
        let parser = StoryboardFile3_0Parser(applicationInfo: applicationInfo)
        return try parser.parse(indexer)
    }
    
    internal let applicationInfo : ApplicationInfo
    
    internal var storyboardInstanceParseInfo : StoryboardInstanceParseInfo?
    
    internal var parsedSegues = [SegueInstanceParseInfo]()
    
    internal var logs : [String]?
    internal func Log(message : String) {
        if logs == nil
        {
            logs = [String]()
        }
        logs?.append(message)
    }
    
    required init(applicationInfo : ApplicationInfo)
    {
        self.applicationInfo = applicationInfo
        
        super.init()
    }

    func parse(indexer : XMLIndexer) throws -> StoryboardFileParser.ParseResult {
        var result : StoryboardFileParser.ParseResult
        
        self.storyboardInstanceParseInfo = self.createStoryboardInstance(indexer)
        
        if let storyboardInstanceParseInfo = self.storyboardInstanceParseInfo
        {
            self.parseScenes(indexer["document"]["scenes"], storyboardInstanceParseInfo: storyboardInstanceParseInfo)
            
            self.createSegueInstanceInfosFromParsed()
            
            result = try self.createStoryboardInstanceInfoFromParsed()
        }
        
        return result
    }
}
