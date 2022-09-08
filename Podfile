# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source ‘https://github.com/CocoaPods/Specs.git‘


target 'LKXFrameworkForiOS' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for LKXFrameworkForiOS
  pod 'SDWebImage', '~> 5.8.3'
  pod 'AFNetworking', '~> 4.0.1'
  pod 'MJRefresh', '~> 3.4.3'
  pod 'MJExtension', '~> 3.2.2'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SDCycleScrollView', '~> 1.80'
  pod 'Masonry', '~> 1.1.0'
  pod 'Reachability', '~> 3.2'
  pod 'YKWoodpecker', '~> 1.2.8'

  target 'LKXFrameworkForiOSTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LKXFrameworkForiOSUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
      end
    end
  end

end
