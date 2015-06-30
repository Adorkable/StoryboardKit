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
    static func supports(root : XMLIndexer) -> Bool
    init(applicationInfo : ApplicationInfo)
    func parse(indexer : XMLIndexer) -> StoryboardFileParser.ParseResult
}

/**
*  Parses storyboard files
*/
public class StoryboardFileParser: NSObject {
    /**
     * Result value after parsing a Storyboard file
     */
    public typealias ParseResult = (StoryboardInstanceInfo?, NSError?)
    
    /**
    Main parsing function
    
    :param: applicationInfo The applicationInfo instance you wish to fill
    :param: pathFileName    The path to the Storyboard file
    
    :returns: A StoryboardInstanceInfo that represents the parsed Storyboard file and/or an error, either nilled depending on the parsing results
    */
    public class func parse(applicationInfo : ApplicationInfo, pathFileName : String) -> ParseResult {
        var result : ParseResult
        
        if NSFileManager.defaultManager().fileExistsAtPath(pathFileName) {
            
            if let data = NSData(contentsOfFile: pathFileName)
            {
                let indexer = SWXMLHash.parse(data)
                result = self.parseXML(indexer, applicationInfo: applicationInfo)
            } else
            {
                result = (nil, NSError(domain: "Unable to open Storyboard file \(pathFileName)", code: 0, userInfo: nil) )
            }
        } else
        {
            result = (nil, NSError(domain: "Unable to find Storyboard file \(pathFileName)", code: 0, userInfo: nil) )
        }
        
        return result
    }
    
    internal static let versionedParserClasses : [StoryboardFileVersionedParser.Type] = [StoryboardFile3_0Parser.self]
    
    internal class func parseXML(indexer : XMLIndexer, applicationInfo : ApplicationInfo) -> ParseResult {
        var result : ParseResult
        
        // TODO: fix in Swift 2.0 to use versionsedParserClasses
        if StoryboardFile3_0Parser.supports(indexer)
        {
            var parser = StoryboardFile3_0Parser(applicationInfo: applicationInfo)
            
            result = parser.parse(indexer)
        } else
        {
            result = (nil, NSError(domain: "Unsupported Storyboard file format version: \(version)", code: 0, userInfo: nil) )
        }
        
        return result
    }
}
