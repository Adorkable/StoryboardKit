//
//  StoryboardFileParser.swift
//  StoryboardKit
//
//  Created by Ian on 5/3/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

/**
*  Interface for implementing a Version Specific Storyboard File Parser
*/
protocol StoryboardFileVersionedParser {
    init(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo)
    func parse(indexer : XMLIndexer) -> NSError?
}

/**
*  Parses storyboard files
*/
public class StoryboardFileParser: NSObject {
    /**
    Main parsing function
    
    :param: applicationInfo The applicationInfo instance you wish to fill
    :param: storyboardInfo  The storyboardInfo instance you wish to fill
    :param: pathFileName    The path to the Storyboard file
    */
    public class func parse(applicationInfo : ApplicationInfo, storyboardInfo : StoryboardInstanceInfo, pathFileName : String) {
        // TODO: shouldn't this return a StoryboardInstanceInfo?
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
    
    internal var versionedParsers = [
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
