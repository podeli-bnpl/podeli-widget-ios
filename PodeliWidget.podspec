Pod::Spec.new do |spec|
  spec.name         = "PodeliWidget"
  spec.version      = "0.0.5"
  spec.summary      = "PodeliWidget framework"
  

  spec.author       = "Podeli"
  spec.homepage     = "https://podeli.ru"
  spec.license      = "proprietary"

  spec.ios.deployment_target = "11.0"
  spec.swift_version = "5.0"
  spec.source = { :git => "https://github.com/podeli-bnpl/podeli-widget-ios.git", :tag => "#{spec.version}" }
  spec.source_files = "PodeliWidget/**/*.{swift,h,m}"
  spec.resources = 'PodeliWidget/Assets.xcassets', 'PodeliWidget/Fonts/*.{ttf,otf}'

  end
