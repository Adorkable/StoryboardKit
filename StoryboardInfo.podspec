Pod::Spec.new do |s|

  s.name         = "StoryboardInfo"
  s.version      = "0.1.0"
  s.summary      = "All you would want to know about yer Storyboards"

  s.homepage     = "https://github.com/Adorkable/StoryboardInfo.git"

  s.author       = { "Ian G" => "yo.ian.g@gmail.com" }
  s.platform     = :osx, "10.10"

  s.source       = { :git => "https://github.com/Adorkable/StoryboardInfo", :tag => "0.1.0" }

  s.source_files = "StoryboardInfo/*.swift"

  s.requires_arc = true

  s.dependency 'SWXMLHash'
end
