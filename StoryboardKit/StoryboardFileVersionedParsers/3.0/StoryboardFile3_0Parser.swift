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
    
    internal let applicationInfo : ApplicationInfo
    
    internal var storyboardInstanceParseInfo : StoryboardInstanceParseInfo?
    
    internal var parsedSegues = Array<SegueInstanceParseInfo>()
    
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
