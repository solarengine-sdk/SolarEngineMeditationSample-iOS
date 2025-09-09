# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
source 'https://github.com/CocoaPods/Specs.git'


target 'SolarEngineMeditationSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SolarEngineMeditationSample
  pod 'Google-Mobile-Ads-SDK'
  pod 'AppLovinSDK'
  pod 'AnyThinkiOS','6.4.91'
  
  # gromore
  # 7100版本以下
  pod 'Ads-CN', '6.6.1.0', :subspecs => ['BUAdSDK','CSJMediation','BUAdLive']

#  # 7100版本及以上
#  pod 'Ads-CN', '7.1.0.0', :subspecs => ['BUAdSDK','CSJMediation-Only' ,'BUAdLive']

  # 以下根据需求任选其一
  # TTSDK动态库版本
#  pod 'TTSDKFramework', '1.46.2.7-premium', :subspecs => ['LivePull-Lite'], :source => 'https://github.com/volcengine/volcengine-specs'

  # TTSDK静态库版本
  pod 'TTSDK', '1.46.2.7-premium', :subspecs => ['LivePull-Lite'], :source => 'https://github.com/volcengine/volcengine-specs'
  
  
  pod 'IronSourceSDK'

  pod 'SolarEngineSDK', '~> 1.3.0.3'

  target 'SolarEngineMeditationSampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SolarEngineMeditationSampleUITests' do
    # Pods for testing
  end

end
