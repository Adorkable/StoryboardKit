//
//  StoryboardFile3_0Parser_Views.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

// TODO: move to keypath based parsing
extension StoryboardFile3_0Parser {
    // MARK: Views
    
    internal func createView(view : XMLIndexer) -> ViewInstanceInfo? {
        var result : ViewInstanceInfo?
        
        if let element = view.element,
            let id = element.attributes["id"]
        {
            // TODO: support all View classes
            var useClass : String
            if let customClass = element.attributes["customClass"]
            {
                useClass = customClass
            } else
            {
                useClass = ViewClassInfo.defaultClass
            }
            
            var viewClass = self.applicationInfo.viewClassWithClassName(useClass)
            if viewClass == nil
            {
                viewClass = ViewClassInfo(className: useClass)
                self.applicationInfo.add(viewClass: viewClass!)
            }
            
            var frame : CGRect?
            var autoResizingMaskWidthSizable : Bool = false
            var autoResizingMaskHeightSizable : Bool = false
            var subviews : [ViewInstanceInfo]?
            var backgroundColor : NSColor?
            
            for subnode in view.children
            {
                if let subelement = subnode.element
                {
                    if subelement.name == "rect" && subelement.attributes["key"] == "frame"
                    {
                        
                        frame = self.createRect(subnode)
                        
                    } else if subelement.name == "autoresizingMask" && subelement.attributes["key"] == "autoresizingMask"
                    {
                        
                        self.getAutoresizingMaskValues(subnode, widthSizable: &autoResizingMaskWidthSizable, heightSizable: &autoResizingMaskHeightSizable)
                        
                    } else if subelement.name == "subviews"
                    {
                        subviews = [ViewInstanceInfo]()
                        for subviewNode in subnode.children
                        {
                            if let subview = self.createView(subviewNode)
                            {
                                subviews?.append(subview)
                            }
                        }
                        
                    } else if subelement.name == "color"
                    {
                        var color = self.createColor(subnode)
                        if subelement.attributes["key"] == "backgroundColor"
                        {
                            backgroundColor = color
                        }
                    } else if subelement.name == "constraints"
                    {
                        // TODO:
                    }
                }
            }
            //            var backgroundColor : NSColor? // TODO: Efff, why is there a UIColor? Make our own color object?
            //            var constraints : [NSLayoutConstraint]? // TODO: these definitely need to be our own objects
            
            var view = ViewInstanceInfo(classInfo: viewClass!, id: id, frame: frame, autoResizingMaskWidthSizable: autoResizingMaskWidthSizable,  autoResizingMaskHeightSizable: autoResizingMaskHeightSizable, subviews: subviews, backgroundColor: backgroundColor)
            result = view
        }
        
        return result
    }
    
    internal func createRect(rect : XMLIndexer) -> CGRect? {
        var result : CGRect?
        
        if let element = rect.element,
            let x = (element.attributes["x"] as NSString?)?.doubleValue,
            let y = (element.attributes["y"] as NSString?)?.doubleValue,
            let width = (element.attributes["width"] as NSString?)?.doubleValue,
            let height = (element.attributes["height"] as NSString?)?.doubleValue
        {
            result = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
        }
        
        return result
    }
    
    internal func getAutoresizingMaskValues(autoresizingMask : XMLIndexer, inout widthSizable : Bool, inout heightSizable : Bool) {
        
        if let element = autoresizingMask.element
        {
            widthSizable = element.attributes["widthSizable"] == "YES"
            heightSizable = element.attributes["heightSizable"] == "YES"
        }
    }
    
    internal func createColor(color : XMLIndexer) -> NSColor? {
        var result : NSColor?
        
        if let element = color.element
        {
            if let colorSpace = element.attributes["colorSpace"]
            {
                if colorSpace == "calibratedWhite"
                {
                    if let white = (element.attributes["white"] as NSString?)?.doubleValue,
                        let alpha = (element.attributes["alpha"] as NSString?)?.doubleValue
                    {
                        result = NSColor(calibratedWhite: CGFloat(white), alpha: CGFloat(alpha))
                    } else
                    {
                        NSLog("Error: Unable to find expected members of colorspace \(colorSpace)")
                    }
                } else if colorSpace == "calibratedRGB"
                {
                    if let red = (element.attributes["red"] as NSString?)?.doubleValue,
                        let green = (element.attributes["green"] as NSString?)?.doubleValue,
                        let blue = (element.attributes["green"] as NSString?)?.doubleValue,
                        let alpha = (element.attributes["alpha"] as NSString?)?.doubleValue
                    {
                        result = NSColor(calibratedRed: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha) )
                    } else
                    {
                        NSLog("Error: Unable to find expected members of colorspace \(colorSpace)")
                    }
                } else if colorSpace == "custom",
                        let customColorSpace = element.attributes["customColorSpace"]
                {
                    if customColorSpace == "genericCMYKColorSpace",
                        let cyan = (element.attributes["cyan"] as NSString?)?.doubleValue,
                        let magenta = (element.attributes["magenta"] as NSString?)?.doubleValue,
                        let yellow = (element.attributes["yellow"] as NSString?)?.doubleValue,
                        let black = (element.attributes["black"] as NSString?)?.doubleValue,
                        let alpha = (element.attributes["alpha"] as NSString?)?.doubleValue
                    {
                        // TODO: what's "device" NSColor's difference?
                        result = NSColor(deviceCyan: CGFloat(cyan), magenta: CGFloat(magenta), yellow: CGFloat(yellow), black: CGFloat(black), alpha: CGFloat(alpha) )
                    } else
                    {
                        NSLog("Error: Unknown custom colorspace \(customColorSpace)")
                    }

                } else
                {
                    NSLog("Error: Unknown colorspace \(colorSpace)")
                }
            } else if let cocoaTouchSystemColor = element.attributes["cocoaTouchSystemColor"]
            {
                // cocoaTouchSystemColor="darkTextColor"
            } else
            {
                NSLog("Unsupported color format: \(element)")
            }
        }
        
        return result
    }
}