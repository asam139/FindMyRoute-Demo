# Uncomment the next line to define a global platform for your project
platform :ios, '13.6'

target 'FindMyRoute-Demo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Networking
  pod 'Moya/RxSwift', '~> 14.0'

  # Rx
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'

  # UI
  pod 'RxGoogleMaps', '~> 4.0'

  # Code quality
  pod 'SnapKit', '~> 5.0'
  pod 'SwifterSwift', '~> 5.0'  # https://github.com/SwifterSwift/SwifterSwift

  # Tools
  pod 'SwiftLint', '0.40.0'


  target 'FindMyRoute-DemoTests' do
    inherit! :search_paths

    # Rx
    pod 'RxBlocking', '~> 5.0'
    pod 'RxTest', '~> 5.0'
  end

  target 'FindMyRoute-DemoUITests' do
    # Pods for testing
  end

end
