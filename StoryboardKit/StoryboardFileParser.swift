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
    static func parse(indexer : XMLIndexer, applicationInfo : ApplicationInfo) throws -> StoryboardFileParser.ParseResult
}

/**
*  Parses storyboard files
*/
public class StoryboardFileParser: NSObject {
    /**
     * Result value after parsing a Storyboard file
     */
    public typealias ParseResult = (StoryboardInstanceInfo?, [String]?)
    
    /**
    Main parsing function
    
    - parameter applicationInfo: The applicationInfo instance you wish to fill
    - parameter pathFileName:    The path to the Storyboard file
    
    - returns: A StoryboardInstanceInfo that represents the parsed Storyboard file and/or an error, and/or any verbose feedback, any of which non-nil or nil depending on the parsing results
    */
    public class func parse(applicationInfo : ApplicationInfo, pathFileName : String) throws -> ParseResult {
        var result : ParseResult
        
        if NSFileManager.defaultManager().fileExistsAtPath(pathFileName) {
            
            if let data = NSData(contentsOfFile: pathFileName)
            {
                let indexer = SWXMLHash.parse(data)
                result = try self.parseXML(indexer, applicationInfo: applicationInfo)
            } else
            {
                throw NSError(domain: "Unable to open Storyboard file \(pathFileName)", code: 0, userInfo: nil)
            }
        } else
        {
            throw NSError(domain: "Unable to find Storyboard file \(pathFileName)", code: 0, userInfo: nil)
        }
        
        return result
    }
    
    internal static let versionedParserClasses : [StoryboardFileVersionedParser.Type] = [StoryboardFile3_0Parser.self]
    
    internal class func parseXML(indexer : XMLIndexer, applicationInfo : ApplicationInfo) throws -> ParseResult {
        var result : ParseResult
        
        // TODO: fix to use versionsedParserClasses
        if StoryboardFile3_0Parser.supports(indexer)
        {
            result = try StoryboardFile3_0Parser.parse(indexer, applicationInfo: applicationInfo)
        } else
        {
            throw NSError(domain: "Unsupported Storyboard file format version: \(version)", code: 0, userInfo: nil)
        }
        
        return result
    }
}
