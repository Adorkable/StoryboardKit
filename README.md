StoryboardKit
===

[![Pod Version](http://img.shields.io/cocoapods/v/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/BingAPI/)
[![Pod Platform](http://img.shields.io/cocoapods/p/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/BingAPI/)
[![Pod License](http://img.shields.io/cocoapods/l/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/BingAPI/)
[![Build Status](http://img.shields.io/travis/Adorkable/StoryboardKit.svg?branch=master&style=flat)](https://travis-ci.org/Adorkable/BingAPIiOS)

**StoryboardKit** a simple OSX library that tells you all you would want to know about storyboard files.

Currently it supports iOS storyboards only. OSX storyboard support forthcoming!

Installation
---
---
**StoryboardKit** is available through **[cocoapods](http://cocoapods.org)**, to install simple add the following line to your `PodFile`:

``` ruby
  pod "StoryboardKit"
```

Alternatively you can add the **[github repo](https://github.com/Adorkable/StoryboardKit)** as a submodule and use **StoryboardKit** as a framework.

Setup and Usage
---
---
The library uses two "root" level objects to provide the tree of information you'll need:

* `ApplicationInfo` - contains all information global to your application such as class information as well as instance information 
* `StoryboardInfo` - contains all information specific to a particular Storyboard file

As such you can pass around an `ApplicationInfo` instance to multiple parses but you most likely want to create a new `StoryboardInfo` for each Storyboard file you parse.

To parse a Storyboard file:

``` swift
	var storyboardInfo = StoryboardInstanceInfo()
	var applicationInfo = ApplicationInfo()
	StoryboardFileParser.parse(applicationInfo, storyboardInfo: storyboardInfo, pathFileName: "ParseMe.storyboard" )
```

Contributing
---
If you have any ideas, suggestions or bugs to report please [create an issue](https://github.com/Adorkable/BingAPIiOS/issues/new) labeled *feature* or *bug* (check to see if the issue exists first please!). 

Or submit a pull request, there is a lot more work to be done!