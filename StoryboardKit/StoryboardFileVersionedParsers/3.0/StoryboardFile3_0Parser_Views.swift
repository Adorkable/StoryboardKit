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
internal extension StoryboardFile3_0Parser {
    // MARK: Views
    
    class ViewInstanceParseInfo {
        let id : String
        let useClass : String
        let viewClass : ViewClassInfo
        let frame : CGRect?
        let autoResizingMaskWidthSizable : Bool
        let autoResizingMaskHeightSizable : Bool
        let subviews : [ViewInstanceInfo]?
        var backgroundColor : NSColor?
        
        init(id : String, frame : CGRect?, useClass : String, viewClass : ViewClassInfo, autoResizingMaskWidthSizable : Bool, autoResizingMaskHeightSizable : Bool, subviews : [ViewInstanceInfo]?, backgroundColor : NSColor?) {
            self.id = id

            self.frame = frame
            
            self.useClass = useClass
            self.viewClass = viewClass
            
            self.autoResizingMaskWidthSizable = autoResizingMaskWidthSizable
            self.autoResizingMaskHeightSizable = autoResizingMaskHeightSizable
            
            self.subviews = subviews
            
            self.backgroundColor = backgroundColor
        }
    }
    
    internal func parseSubviews(subnode : XMLIndexer) -> [ViewInstanceInfo]? {
        var result : [ViewInstanceInfo]?

        var subviews = [ViewInstanceInfo]()
        for subviewNode in subnode.children
        {
            if let subviewElement = subviewNode.element
            {
                if subviewElement.name == "tableView"
                {
                    if let subview = self.createTableView(subviewNode)
                    {
                        subviews.append(subview)
                    } else
                    {
                        // TODO:
                    }
                } else if subviewElement.name == "collectionView"
                {
                    if let subview = self.createCollectionView(subviewNode)
                    {
                        subviews.append(subview)
                    } else
                    {
                        // TODO:
                    }
                } else
                {
                    if subviewElement.name != "view"
                    {
                        self.Log("Unhandled subview type \(subviewElement.name), defaulting to basic view")
                    }
                    if let subview = self.createView(subviewNode)
                    {
                        subviews.append(subview)
                    } else
                    {
                        // TODO:
                    }
                }
            }
        }
        if subviews.count > 0
        {
            result = subviews
        }
        
        return result
    }
    
    internal func parseView(view : XMLIndexer, viewClassInfoClass : ViewClassInfo.Type) -> ViewInstanceParseInfo? {
        var result : ViewInstanceParseInfo?
        
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
                useClass = viewClassInfoClass.defaultClass
            }
            
            var viewClass : ViewClassInfo
            if let foundViewClass = self.applicationInfo.viewClassWithClassName(useClass)
            {
                viewClass = foundViewClass
            } else
            {
                viewClass = viewClassInfoClass.init(className: useClass)
                self.applicationInfo.add(viewClass: viewClass)
            }
            
            var frame : CGRect?
            var autoResizingMaskWidthSizable : Bool = false
            var autoResizingMaskHeightSizable : Bool = false
            var subviews : [ViewInstanceInfo]?
            var backgroundColor : NSColor?
            
            // TODO: support subclass parser handling of subnode rather than traversing multiple times
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
                        
                        subviews = self.parseSubviews(subnode)
                    } else if subelement.name == "color"
                    {
                        let color = self.createColor(subnode)
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
            result = ViewInstanceParseInfo(id: id, frame: frame, useClass: useClass, viewClass: viewClass, autoResizingMaskWidthSizable: autoResizingMaskWidthSizable, autoResizingMaskHeightSizable: autoResizingMaskHeightSizable, subviews: subviews, backgroundColor: backgroundColor)
        }
        
        return result
    }
    
    internal func createView(view : XMLIndexer, viewClassInfoClass : ViewClassInfo.Type = ViewClassInfo.self) -> ViewInstanceInfo? {
        var result : ViewInstanceInfo?
        if let parseInfo = self.parseView(view, viewClassInfoClass: viewClassInfoClass)
        {
            let view = ViewInstanceInfo(classInfo: parseInfo.viewClass, id: parseInfo.id, frame: parseInfo.frame, autoResizingMaskWidthSizable: parseInfo.autoResizingMaskWidthSizable,  autoResizingMaskHeightSizable: parseInfo.autoResizingMaskHeightSizable, subviews: parseInfo.subviews, backgroundColor: parseInfo.backgroundColor)
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
                        self.Log("Error: Unable to find expected members of colorspace \(colorSpace)")
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
                        self.Log("Error: Unable to find expected members of colorspace \(colorSpace)")
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
                        self.Log("Error: Unknown custom colorspace \(customColorSpace)")
                    }

                } else
                {
                    self.Log("Error: Unknown colorspace \(colorSpace)")
                }
            } else if let _ = element.attributes["cocoaTouchSystemColor"]
            {
                // cocoaTouchSystemColor="darkTextColor"
            } else
            {
                self.Log("Unsupported color format: \(element)")
            }
        }
        
        return result
    }
    
    class TableViewInstanceParseInfo {
        // TODO: feels like a hack to contain the superclass's parse info
        let viewInstanceParseInfo : ViewInstanceParseInfo
        let cellPrototypes : [TableViewInstanceInfo.TableViewCellPrototypeInfo]?
        
        init(viewInstanceParseInfo : ViewInstanceParseInfo, cellPrototypes : [TableViewInstanceInfo.TableViewCellPrototypeInfo]?) {
            self.viewInstanceParseInfo = viewInstanceParseInfo
            self.cellPrototypes = cellPrototypes
        }
    }
    
    internal func parseTableView(tableView : XMLIndexer) -> TableViewInstanceParseInfo? {
        var result : TableViewInstanceParseInfo?
        
        if let parseInfo = self.parseView(tableView, viewClassInfoClass: TableViewClassInfo.self)
        {
            var cellPrototypes : [TableViewInstanceInfo.TableViewCellPrototypeInfo]?
            
            for subnode in tableView.children
            {
                if let subelement = subnode.element
                {
                    if subelement.name == "prototypes"
                    {
                        cellPrototypes = self.createTableViewCellPrototypes(subnode)
                    }
                }
            }
            
            result = TableViewInstanceParseInfo(viewInstanceParseInfo: parseInfo, cellPrototypes: cellPrototypes)
        }
        
        return result
    }
    
    internal func createTableViewCellPrototypes(prototypes : XMLIndexer) -> [TableViewInstanceInfo.TableViewCellPrototypeInfo]? {
        var result : [TableViewInstanceInfo.TableViewCellPrototypeInfo]?
        
        for subnode in prototypes.children
        {
            if let subelement = subnode.element
            {
                if subelement.name == "tableViewCell"
                {
                    if let cellPrototype = self.createTableViewCellPrototype(subnode)
                    {
                        if result == nil
                        {
                            result = Array<TableViewInstanceInfo.TableViewCellPrototypeInfo>()
                        }
                        
                        result!.append(cellPrototype)
                    }
                } else
                {
                    self.Log("Error: Unknown prototype type \(subelement.name)")
                }
            }
        }
        
        return result
    }

    internal func createTableViewCellPrototype(tableViewCell : XMLIndexer) -> TableViewInstanceInfo.TableViewCellPrototypeInfo? {
        var result : TableViewInstanceInfo.TableViewCellPrototypeInfo?
        
        if let element = tableViewCell.element,
            let id = element.attributes["id"]
        {
            let reuseIdentifier = element.attributes["reuseIdentifier"]
            result = TableViewInstanceInfo.TableViewCellPrototypeInfo(id: id, reuseIdentifier: reuseIdentifier)
        }
        
        return result
    }
    
    internal func createTableView(tableView : XMLIndexer) -> TableViewInstanceInfo? {
        var result : TableViewInstanceInfo?
        if let parseInfo = self.parseTableView(tableView)
        {
            let viewInstanceParseInfo = parseInfo.viewInstanceParseInfo
            
            let tableView = TableViewInstanceInfo(classInfo: viewInstanceParseInfo.viewClass, id: viewInstanceParseInfo.id, frame: viewInstanceParseInfo.frame, autoResizingMaskWidthSizable: viewInstanceParseInfo.autoResizingMaskWidthSizable,  autoResizingMaskHeightSizable: viewInstanceParseInfo.autoResizingMaskHeightSizable, subviews: viewInstanceParseInfo.subviews, backgroundColor: viewInstanceParseInfo.backgroundColor, cellPrototypes: parseInfo.cellPrototypes)
            result = tableView
        }
        
        return result
    }
    
    class CollectionViewInstanceParseInfo {
        // TODO: feels like a hack to contain the superclass's parse info
        let viewInstanceParseInfo : ViewInstanceParseInfo
        let cellPrototypes : [CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo]?
        
        init(viewInstanceParseInfo : ViewInstanceParseInfo, cellPrototypes : [CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo]?) {
            self.viewInstanceParseInfo = viewInstanceParseInfo
            self.cellPrototypes = cellPrototypes
        }
    }
    
    internal func parseCollectionView(collectionView : XMLIndexer) -> CollectionViewInstanceParseInfo? {
        var result : CollectionViewInstanceParseInfo?
        
        if let parseInfo = self.parseView(collectionView, viewClassInfoClass: CollectionViewClassInfo.self)
        {
            var cellPrototypes : [CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo]?
            
            for subnode in collectionView.children
            {
                if let subelement = subnode.element
                {
                    if subelement.name == "cells"
                    {
                        cellPrototypes = self.createCollectionViewCellPrototypes(subnode)
                    }
                }
            }
            
            result = CollectionViewInstanceParseInfo(viewInstanceParseInfo: parseInfo, cellPrototypes: cellPrototypes)
        }
        
        return result
    }

    internal func createCollectionViewCellPrototypes(prototypes : XMLIndexer) -> [CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo]? {
        var result : [CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo]?
        
        for subnode in prototypes.children
        {
            if let subelement = subnode.element
            {
                if subelement.name == "collectionViewCell"
                {
                    if let cellPrototype = self.createCollectionViewCellPrototype(subnode)
                    {
                        if result == nil
                        {
                            result = Array<CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo>()
                        }
                        
                        result!.append(cellPrototype)
                    }
                } else
                {
                    self.Log("Error: Unknown prototype type \(subelement.name)")
                }
            }
        }
        
        return result
    }
    
    internal func createCollectionViewCellPrototype(collectionViewCell : XMLIndexer) -> CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo? {
        var result : CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo?
        
        if let element = collectionViewCell.element,
            let id = element.attributes["id"]
        {
            let reuseIdentifier = element.attributes["reuseIdentifier"]
            result = CollectionViewInstanceInfo.CollectionViewCellPrototypeInfo(id: id, reuseIdentifier: reuseIdentifier)
        }
        
        return result
    }

    internal func createCollectionView(collectionView : XMLIndexer) -> CollectionViewInstanceInfo? {
        var result : CollectionViewInstanceInfo?
        if let parseInfo = self.parseCollectionView(collectionView)
        {
            let viewInstanceParseInfo = parseInfo.viewInstanceParseInfo
            
            let collectionView = CollectionViewInstanceInfo(classInfo: viewInstanceParseInfo.viewClass, id: viewInstanceParseInfo.id, frame: viewInstanceParseInfo.frame, autoResizingMaskWidthSizable: viewInstanceParseInfo.autoResizingMaskWidthSizable,  autoResizingMaskHeightSizable: viewInstanceParseInfo.autoResizingMaskHeightSizable, subviews: viewInstanceParseInfo.subviews, backgroundColor: viewInstanceParseInfo.backgroundColor, cellPrototypes: parseInfo.cellPrototypes)
            result = collectionView
        }
        
        return result
    }
}