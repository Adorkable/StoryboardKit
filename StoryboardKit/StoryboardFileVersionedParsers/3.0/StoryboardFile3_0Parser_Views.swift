//
//  StoryboardFile3_0Parser_Views.swift
//  StoryboardKit
//
//  Created by Ian on 6/30/15.
//  Copyright (c) 2015 Adorkable. All rights reserved.
//

import Foundation

import SWXMLHash

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
                        if subelement.attributes["key"] == "backgroundColor"
                        {
                            // TODO:
                        }
                    } else if subelement.name == "constraints"
                    {
                        // TODO:
                    }
                }
            }
            //            var backgroundColor : NSColor? // TODO: Efff, why is there a UIColor? Make our own color object?
            //            var constraints : [NSLayoutConstraint]? // TODO: these definitely need to be our own objects
            
            var view = ViewInstanceInfo(classInfo: viewClass!, id: id, frame: frame, autoResizingMaskWidthSizable: autoResizingMaskWidthSizable,  autoResizingMaskHeightSizable: autoResizingMaskHeightSizable, subviews: subviews)
            result = view
        }
        
        return result
    }
    
    internal func createRect(rect : XMLIndexer) -> CGRect? {
        var result : CGRect?
        
        if let element = rect.element,
            let x = (element.attributes["x"] as NSString?)?.floatValue,
            let y = (element.attributes["y"] as NSString?)?.floatValue,
            let width = (element.attributes["width"] as NSString?)?.floatValue,
            let height = (element.attributes["height"] as NSString?)?.floatValue
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
}