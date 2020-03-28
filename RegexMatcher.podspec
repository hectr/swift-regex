Pod::Spec.new do |s|
  s.name             = 'RegexMatcher'
  s.version          = '1.2.0'
  s.summary          = 'NSRegularExpression wrapper'

  s.description      = <<-DESC
NSRegularExpression wrapper written in Swift.
                       DESC

  s.homepage         = 'https://github.com/hectr/swift-regex'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hectr' => 'h@mrhector.me' }
  s.source           = { :git => 'https://github.com/hectr/swift-regex.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/elnetus'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.13'

  s.source_files = 'Sources/RegexMatcher/**/*'
end
