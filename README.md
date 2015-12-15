StoryboardKit
===
[![Build Status](http://img.shields.io/travis/Adorkable/StoryboardKit.svg?branch=master&style=flat)](https://travis-ci.org/Adorkable/StoryboardKit)
[![codecov.io](https://img.shields.io/codecov/c/github/Adorkable/StoryboardKit.svg)](http://codecov.io/github/Adorkable/StoryboardKit?branch=master)
[![Pod Platform](http://img.shields.io/cocoapods/p/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/StoryboardKit/)
[![Pod License](http://img.shields.io/cocoapods/l/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/StoryboardKit/)
[![Pod Version](http://img.shields.io/cocoapods/v/StoryboardKit.svg?style=flat)](http://cocoadocs.org/docsets/StoryboardKit/)

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

Carthage support soon!

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

From here you can access things like the list of all **ViewControllerClassInfo**s or **ViewControllerInstanceInfo**s in the app through your **ApplicationInfo** instance

``` swift
	for viewControllerClass in application.viewControllerClasses {
		...
	}
```

Or perhaps you'll traverse through your Storyboard graph via the **StoryboardInstanceInfo**'s **initialViewController** or **scenes** list.

``` swift
	guard let initialViewController = storyboardInfo.initialViewController else { ... }
	guard let initialView = initialViewController.view else { ... }
	
	guard let subviews = initialView.subviews else { ... }
	
	for subview in subviews {
		...
	}
```

To learn more about the information **StoryboardKit** currently parses please read the docs here: [cocoadocs.org](http://cocoadocs.org/docsets/StoryboardKit/)

To see an example of **StoryboardKit** in use check out the _seguecode_ repo here: [seguecode](https://github.com/Adorkable/seguecode)

Contributing
---
If you have any ideas, suggestions or bugs to report please [create an issue](https://github.com/Adorkable/StoryboardKit/issues/new) labeled *feature* or *bug* (check to see if the issue exists first please!). 

Or submit a pull request, there is a lot more work to be done!
