Pod::Spec.new do |s|

  s.name         = "StoryboardKit"
  s.version      = "0.3.0"
  s.summary      = "All you would want to know about yer Storyboards"

  s.homepage     = "https://github.com/Adorkable/StoryboardKit.git"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :osx, "10.10"

  s.license      = "MIT"

  s.source       = { :git => "https://github.com/Adorkable/StoryboardKit.git", :tag => s.version.to_s }

  s.source_files = "StoryboardKit/*.swift", "StoryboardKit/StoryboardFileVersionedParsers/*.swift"

  s.requires_arc = true

  s.dependency 'SWXMLHash'
end
