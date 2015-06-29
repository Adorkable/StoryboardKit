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
    let applicationInfo : ApplicationInfo
    
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
    
    // MARK: Storyboard
    
    internal class StoryboardInstanceParseInfo : NSObject {
//        internal var fileType : String
//        internal var fileVersion : String
//        internal var toolsVersion : String
//        internal var systemVersion : String
//        internal var targetRuntime : String
//        internal var propertyAccessControl : String

        internal var useAutolayout : Bool
        internal var useTraitCollections : Bool
        internal var initialViewControllerId : String?
        
        init(useAutolayout : Bool, useTraitCollections : Bool, initialViewControllerId : String?) {
            self.useAutolayout = useAutolayout
            self.useTraitCollections = useTraitCollections
            self.initialViewControllerId = initialViewControllerId
            
            super.init()
        }
        
        var scenes : [StoryboardInstanceInfo.SceneInfo] = Array<StoryboardInstanceInfo.SceneInfo>()
        
        func add(#scene : StoryboardInstanceInfo.SceneInfo) {
            // TODO: validate that it isn't a dup
            self.scenes.append(scene)
        }
    }
    
    internal var storyboardInstanceParseInfo : StoryboardInstanceParseInfo?
    
    internal func createStoryboardInstance(root : XMLIndexer) -> StoryboardInstanceParseInfo? {
        var result : StoryboardInstanceParseInfo?
        
        if let document = root["document"].element
        {
            var useAutolayout = document.attributes["useAutolayout"] == "YES"
            var useTraitCollections = document.attributes["useTraitCollections"] == "YES"
            
            var initialViewControllerId = document.attributes["initialViewController"]

            
            var storyboardInstance = StoryboardInstanceParseInfo(useAutolayout: useAutolayout, useTraitCollections: useTraitCollections, initialViewControllerId: initialViewControllerId)
            
            // TODO: StoryboardFileInfo
//            storyboardInstance.fileType = document.attributes["type"]
//            storyboardInstance.fileVersion = document.attributes["version"]
//            storyboardInstance.toolsVersion = document.attributes["toolsVersion"]
//            storyboardInstance.systemVersion = document.attributes["systemVersion"]
//            storyboardInstance.targetRuntime = document.attributes["targetRuntime"]
//            storyboardInstance.propertyAccessControl = document.attributes["propertyAccessControl"]
            
            result = storyboardInstance
        }
        
        return result
    }
    
    internal func createStoryboardInstanceInfoFromParsed() -> StoryboardFileParser.ParseResult {
        var result : StoryboardFileParser.ParseResult
        
        if let storyboardInstanceParseInfo = self.storyboardInstanceParseInfo
        {
            var initialViewController : ViewControllerInstanceInfo?
            
            if let initialViewControllerId = storyboardInstanceParseInfo.initialViewControllerId
            {
                initialViewController = self.applicationInfo.viewControllerInstanceWithId(initialViewControllerId)
            }
            
            var storyboardInstanceInfo = StoryboardInstanceInfo(useAutolayout: storyboardInstanceParseInfo.useAutolayout, useTraitCollections: storyboardInstanceParseInfo.useTraitCollections, initialViewController: initialViewController)
            
            for sceneInfo in storyboardInstanceParseInfo.scenes
            {
                storyboardInstanceInfo.add(scene: sceneInfo)
            }
            
            result = (storyboardInstanceInfo, nil)
        } else
        {
            result = (nil, NSError(domain: "Unable to find StoryboardInstanceParseInfo, likely cause was we were unable to parse root of Storyboard file", code: 0, userInfo: nil) )
        }
        
        return result
    }
    
    // MARK: Scenes
    
    internal func parseScenes(scenes : XMLIndexer, storyboardInstanceParseInfo : StoryboardInstanceParseInfo) {
        for scene in scenes.children {
            
            self.parseIndividualScene(scene, storyboardInstanceParseInfo: storyboardInstanceParseInfo)
        }
    }
    
    internal func parseIndividualScene(scene : XMLIndexer, storyboardInstanceParseInfo : StoryboardInstanceParseInfo) {
        
        if let element = scene.element, let sceneId = element.attributes["sceneID"]
        {
            var sceneInfo = StoryboardInstanceInfo.SceneInfo(sceneId: sceneId)
            storyboardInstanceParseInfo.add(scene: sceneInfo)
            
            var objects = scene["objects"]
            for object in objects.children {
                if let sceneObjectElement = object.element
                {
                    if sceneObjectElement.name == "viewController" || sceneObjectElement.name == "tableViewController"
                    {
                        self.parseViewController(object, sceneInfo: sceneInfo)
                    } else if sceneObjectElement.name == "navigationController"
                    {
                        self.parseNavigationController(object, sceneInfo: sceneInfo)
                    } else
                    {
                        // TODO: placeholder
                        NSLog("Skipping unsupported scene object \(sceneObjectElement.name)")
                    }
                }
            }
        }
    }
    
    // MARK: View Controllers
    
    internal func parseViewController(viewController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = viewController.element, let id = element.attributes["id"]
        {
            var useClass : String
            if let customClass = element.attributes["customClass"]
            {
                useClass = customClass
            } else
            {
                useClass = ViewControllerClassInfo.defaultClass
            }
            
            var viewControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(useClass)
            if viewControllerClassInfo == nil
            {
                viewControllerClassInfo = ViewControllerClassInfo(className: useClass)
                self.applicationInfo.add(viewControllerClass: viewControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            let view = self.createView(viewController["view"]) // Should be using view.key attribute?
            
            var viewControllerInstanceInfo = ViewControllerInstanceInfo(classInfo: viewControllerClassInfo!, id: id, storyboardIdentifier: storyboardIdentifier, view: view)
            
            sceneInfo.controller = viewControllerInstanceInfo
            self.applicationInfo.add(viewControllerInstance: viewControllerInstanceInfo)
            
            self.parseLayoutGuides(viewController["layoutGuides"], source: viewControllerInstanceInfo)
            
            var navigationItem = viewController["navigationItem"]
            if navigationItem.element != nil
            {
                self.parseNavigationItem(navigationItem, source: viewControllerInstanceInfo)
            }
            
            self.parseConnections(viewController["connections"], source: viewControllerInstanceInfo)
        }
    }
    
    // MARK: Navigation Controller
    
    internal func parseNavigationController(navigationController : XMLIndexer, sceneInfo : StoryboardInstanceInfo.SceneInfo) {
        if let element = navigationController.element, let id = element.attributes["id"]
        {
            var useClass : String
            if let customClass = element.attributes["customClass"]
            {
                useClass = customClass
            } else
            {
                useClass = NavigationControllerClassInfo.defaultClass
            }
            
            // TODO: restrict to NavControllerClasses
            var navigationControllerClassInfo = self.applicationInfo.viewControllerClassWithClassName(useClass) as? NavigationControllerClassInfo
            if navigationControllerClassInfo == nil
            {
                navigationControllerClassInfo = NavigationControllerClassInfo(className: useClass)
                self.applicationInfo.add(viewControllerClass: navigationControllerClassInfo!)
            }
            
            let storyboardIdentifier = element.attributes["storyboardIdentifier"]
            let sceneMemberId = element.attributes["sceneMemberID"]
            
            var navigationControllerInstanceInfo = NavigationControllerInstanceInfo(classInfo: navigationControllerClassInfo!, id: id, storyboardIdentifier: storyboardIdentifier, sceneMemberId: sceneMemberId)
            
            sceneInfo.controller = navigationControllerInstanceInfo
            self.applicationInfo.add(navigationControllerInstance: navigationControllerInstanceInfo)
            
            /*            var navigationBar = viewController["navigationBar"] //TODO: can this be optional?
            if navigationBar.element != nil
            {
            self.parseNavigationBar(navigationBar, source: navigationControllerInstanceInfo)
            }
            */
            self.parseConnections(navigationController["connections"], source: navigationControllerInstanceInfo)
        }
    }
    
    // MARK: Layout Guides
    
    internal func parseLayoutGuides(layoutGuides : XMLIndexer, source : ViewControllerInstanceInfo) {
        for layoutGuide in layoutGuides.children
        {
            self.parseLayoutGuide(layoutGuide, source: source)
        }
    }
    
    internal func parseLayoutGuide(layoutGuide : XMLIndexer, source : ViewControllerInstanceInfo) {
        
        if let element = layoutGuide.element,
            let id = element.attributes["id"],
            let type = element.attributes["type"]
        {
            var layoutGuide = ViewControllerLayoutGuideInstanceInfo(id: id, type: type )
            source.add(layoutGuide: layoutGuide)
        } else
        {
            NSLog("Unable to create View Controller Layout Guide Instance Info from \(layoutGuide)")
        }
    }
    
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
            let x = element.attributes["x"],
            let y = element.attributes["y"],
            let width = element.attributes["width"],
            let height = element.attributes["height"]
        {
            
        }
        
        return result
    }
    
    internal func getAutoresizingMaskValues(autoresizingMask : XMLIndexer, inout widthSizable : Bool, inout heightSizable : Bool) {
        
    }
    
    // MARK: Navigation Item
    
    internal func parseNavigationItem(navigationItem : XMLIndexer, source : ViewControllerInstanceInfo) {
        
        switch navigationItem
        {
        case .Element(let element):
                if let element = navigationItem.element,
                    let id = element.attributes["id"],
                    let navigationItemKey = element.attributes["key"],
                    let title = element.attributes["title"]
                {
                    var navigationItem = NavigationItemInstanceInfo(id: id, navigationItemKey: navigationItemKey, title: title)
                    source.add(navigationItem: navigationItem)
                } else
                {
                    NSLog("Unable to create Navigation Item Instance Info from \(navigationItem)")
                }
            break
        case .Error(let error):
                NSLog("Unable to create Navigation Item Instance Info from \(navigationItem): \(error)")
            break
        default:
            NSLog("Unable to create Navigation Item Instance Info from \(navigationItem), unhandled element \(navigationItem.element)")
        }
    }
    
    // MARK: Segues
    
    internal class SegueInstanceParseInfo : NSObject {
        internal let classInfo : SegueClassInfo
        internal let id : String
        internal var source : SegueConnection
        internal let kind : String?
        internal let identifier : String?
        internal let destinationId : String
        internal var destination : SegueConnection?
        
        init(classInfo : SegueClassInfo, id : String, source : SegueConnection, destinationId : String, kind : String?, identifier : String?) {
            self.classInfo = classInfo
            self.id = id
            self.source = source
            self.destinationId = destinationId
            self.kind = kind
            self.identifier = identifier
            
            super.init()
        }
    }
    
    internal func createConnectionParseInfo(connection : XMLIndexer, source : ViewControllerInstanceInfo) -> SegueInstanceParseInfo? {
        var result : SegueInstanceParseInfo?
        
        if let element = connection.element,
            let id = element.attributes["id"],
            let destinationId = element.attributes["destination"]
        {
            var useClass : String
            if let customClass = element.attributes["customClass"]
            {
                useClass = customClass
            } else
            {
                useClass = SegueClassInfo.defaultClass
            }
            
            var segueClass = self.applicationInfo.segueClassWithClassName(useClass)
            if segueClass == nil
            {
                segueClass = SegueClassInfo(className: useClass)
                self.applicationInfo.add(segueClass: segueClass!)
            }
            
            let kind = element.attributes["kind"]
            let identifier = element.attributes["identifier"]
            
            result = SegueInstanceParseInfo(classInfo: segueClass!, id: id, source: StoryboardKit_WeakWrapper(source), destinationId: destinationId, kind: kind, identifier: identifier)
        }
        
        return result
    }
    
    var parsedSegues = Array<SegueInstanceParseInfo>()
    
    internal func parseConnection(connection : XMLIndexer, source : ViewControllerInstanceInfo) {
        if let segueParseInfo = self.createConnectionParseInfo(connection, source: source )
        {
            self.parsedSegues.append(segueParseInfo)
        }
    }
    
    internal func parseConnections(connections : XMLIndexer, source : ViewControllerInstanceInfo) {
        for connection in connections.children
        {
            self.parseConnection(connection, source: source)
        }
    }
    
    internal func createSegueInstanceInfosFromParsed() {
        while self.parsedSegues.count > 0
        {
            var segueParsedInfo = self.parsedSegues.removeLast()

            var segueInfo : SegueInstanceInfo?

            if let destination = self.applicationInfo.viewControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else if let destination = self.applicationInfo.navigationControllerInstanceWithId(segueParsedInfo.destinationId)
            {
                segueInfo = SegueInstanceInfo(classInfo: segueParsedInfo.classInfo, id: segueParsedInfo.id, source: segueParsedInfo.source, destination: destination, kind: segueParsedInfo.kind, identifier: segueParsedInfo.identifier)
            } else
            {
                NSLog("Error linking pending segues, unable to find destination with id \(segueParsedInfo.destinationId)")
            }
            
            if segueInfo != nil {
                if segueInfo!.kind == "relationship" && segueInfo!.source.value is NavigationControllerInstanceInfo {
                    (segueInfo!.source.value as! NavigationControllerInstanceInfo).root = segueInfo
                } else {
                    segueInfo!.source.value!.add(segue: segueInfo!)
                }
            }
        }
    }
}
