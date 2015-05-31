//
//  StoryboardFileParser.swift
//  StoryboardInfo
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

protocol StoryboardFileVersionedParser {
    init(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo)
    func parse(indexer : XMLIndexer) -> NSError?
}

public class StoryboardFileParser: NSObject {
    public class func parse(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo, pathFileName : String) {
        StoryboardFileParser(applicationInfo: applicationInfo, storyboardInfo: storyboardInfo, pathFileName: pathFileName)
    }
    
    internal init(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo, pathFileName : String) {
        
        super.init()

        self.parse(applicationInfo, storyboardInfo: storyboardInfo, pathFileName: pathFileName)
    }
    
    internal func parse(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo, pathFileName : String) {
        if NSFileManager.defaultManager().fileExistsAtPath(pathFileName) {
            if let data = NSData(contentsOfFile: pathFileName)
            {
                let indexer = SWXMLHash.parse(data)
                var result = self.parseXML(indexer, applicationInfo: applicationInfo, storyboardInfo: storyboardInfo)
                
                if result != nil
                {
                    NSLog("Error: when parsing \(result)")
                }
            }
        }
    }
    
    var versionedParsers = [
        "3.0" : StoryboardFile3_0Parser.className()
    ]
    
    internal func parseXML(indexer : XMLIndexer, applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo) -> NSError? {
        var result : NSError?
        
        var version = StoryboardFileParser.getVersion(indexer)
        if version == "3.0"
        {
            var versionedParser = StoryboardFile3_0Parser(applicationInfo: applicationInfo, storyboardInfo: storyboardInfo)
            
            result = versionedParser.parse(indexer)
        } else
        {
            result = NSError(domain: "Unsupported version: \(version)", code: 0, userInfo: nil)
        }
        
        return result
    }
    
    // should this be in the versioned parser? refactor when this becomes more complicated
    internal class func getVersion(indexer : XMLIndexer) -> String? {
        return indexer["document"].element?.attributes["version"];
    }
}
