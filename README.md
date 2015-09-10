StoryboardKit
===

[![Pod Version](http://img.shields.io/cocoapods/v/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/StoryboardKit/)
[![Pod Platform](http://img.shields.io/cocoapods/p/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/StoryboardKit/)
[![Pod License](http://img.shields.io/cocoapods/l/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/StoryboardKit/)
[![Build Status](http://img.shields.io/travis/Adorkable/StoryboardKit.svg?branch=master&style=flat)](https://travis-ci.org/Adorkable/StoryboardKit)

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

To parse a Storyboard file:

``` swift
	var applicationInfo = ApplicationInfo()
	var storyboardInfo = StoryboardFileParser.parse(applicationInfo!, pathFileName: "Main.storyboard")
```

To read more about the information **StoryboardKit** currently parses please read the docs here: [cocoadocs.org](http://cocoadocs.org/docsets/StoryboardKit/)

Contributing
---
If you have any ideas, suggestions or bugs to report please [create an issue](https://github.com/Adorkable/StoryboardKit/issues/new) labeled *feature* or *bug* (check to see if the issue exists first please!). 

Or submit a pull request, there is a lot more work to be done!
