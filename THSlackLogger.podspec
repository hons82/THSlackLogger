Pod::Spec.new do |s|
  s.name					= "THSlackLogger"
  s.version					= "1.0.0"
  s.summary					= "Cocoalumberjack logger to Slack"
  s.description				= <<-DESC
A Logger for [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack) that writes to a custom Slack Channel
DESC
  s.homepage				= "https://github.com/hons82/THSlackLogger"
  s.license					= { :type => "MIT", :file => "LICENSE.md" }
  s.author					= { "Hannes Tribus" => "hons82@gmail.com" }
  s.ios.deployment_target	= "7.0"
  s.osx.deployment_target	= "10.9"
  s.source					= { :git => "https://github.com/hons82/THSlackLogger.git", :tag => "#{s.version}" }
  s.source_files			= "THSlackLogger/*.{h,m}"
  s.requires_arc			= true
  s.dependency				"AFNetworking", "~> 3.0.4"
  s.dependency				"CocoaLumberjack", "~> 2.2.0"
end
