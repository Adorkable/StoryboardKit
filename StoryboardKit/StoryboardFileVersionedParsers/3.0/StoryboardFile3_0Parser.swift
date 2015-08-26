//
//  StoryboardFile3_0Parser.swift
//  StoryboardKit
//
//  Created by Ian on 5/31/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

class StoryboardFile3_0Parser: NSObject, StoryboardFileVersionedParser {
    
    static func supports(root: XMLIndexer) -> Bool {
        var result : Bool
        
        if let version = root["document"].element?.attributes["version"]
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
    
    static func parse(indexer: XMLIndexer, applicationInfo: ApplicationInfo) -> StoryboardFileParser.ParseResult {
        var parser = StoryboardFile3_0Parser(applicationInfo: applicationInfo)
        return parser.parse(indexer)
    }
    
    internal let applicationInfo : ApplicationInfo
    
    internal var storyboardInstanceParseInfo : StoryboardInstanceParseInfo?
    
    internal var parsedSegues = [SegueInstanceParseInfo]()
    
    required init(applicationInfo : ApplicationInfo)
    {
        self.applicationInfo = applicationInfo
        
        super.init()
    }

    func parse(indexer : XMLIndexer) -> StoryboardFileParser.ParseResult {
        var result : StoryboardFileParser.ParseResult
        
        self.storyboardInstanceParseInfo = self.createStoryboardInstance(indexer)
        
        if let storyboardInstanceParseInfo = self.storyboardInstanceParseInfo
        {
            self.parseScenes(indexer["document"]["scenes"], storyboardInstanceParseInfo: storyboardInstanceParseInfo)
            
            self.createSegueInstanceInfosFromParsed()
            
            result = self.createStoryboardInstanceInfoFromParsed()
        }
        
        return result
    }
}
