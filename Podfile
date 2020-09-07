# Uncomment the next line to define a global platform for your project
platform :ios, '13.6'

target 'FindMyRoute-Demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Networking
  pod 'Moya/RxSwift', '~> 14.0'

  # Rx
  # https://github.com/LeoMobileDeveloper/awesome-rxswift
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'RxSwiftExt', '~> 5.0'
  pod 'NSObject+Rx', '~> 5.0'
  pod 'RxOptional', '~> 4.0'
  pod 'RxCoreLocation', '~> 1.5'

  # UI
  pod 'RxGoogleMaps', '~> 4.0'
  pod 'Hero', '~> 1.5'


  # Code quality
  pod 'SnapKit', '~> 5.0'
  pod 'SwifterSwift', '~> 5.0'
  pod 'Codextended', '~> 0.3'

  # Tools
  pod 'SwiftLint', '0.40.0'
  pod 'RandomColorSwift', '~> 2.0'
  pod 'R.swift', '~> 5.0'

  # Logging
  pod 'CocoaLumberjack/Swift', '~> 3.0'

  target 'FindMyRoute-DemoTests' do
    inherit! :none
    pod 'Quick', '~> 3.0'
    pod 'Nimble', '~> 8.0'

    # Rx
    pod 'RxBlocking', '~> 5.0'
    pod 'RxTest', '~> 5.0'
  end

  target 'FindMyRoute-DemoUITests' do
    inherit! :none
  end

end
