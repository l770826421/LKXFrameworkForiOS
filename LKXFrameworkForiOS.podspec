#
#  Be sure to run `pod spec lint LKXFrameworkForiOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "LKXFrameworkForiOS"
  spec.version      = "1.0.2"
  spec.summary      = "iOS应用中的基本工具，持续更新。。。"
  spec.description  = <<-DESC
                    我自己写的一个项目常用的oc类扩展和工具类
                   DESC
  spec.homepage     = "https://github.com/l770826421/LKXFrameworkForiOS.git"
  spec.license      = "MIT"
  spec.author             = { "l770826421" => "770826421@qq.com" }
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/l770826421/LKXFrameworkForiOS.git", :tag => "#{spec.version}" }
  spec.source_files  = "LKXFrameworkForiOS/Classes/Expand/**/*.{h,m}"
  spec.frameworks="Foundation","UIKit"
  spec.xcconfig= { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto" }
  spec.dependency 'SDWebImage'
  spec.dependency 'AFNetworking'
  spec.dependency 'MJRefresh'
  spec.dependency 'MJExtension'
  spec.dependency 'MBProgressHUD'
  spec.dependency 'SDCycleScrollView'
  spec.dependency 'Masonry'
  spec.dependency 'Reachability'
  spec.dependency 'YKWoodpecker'

  spec.requires_arc = false

  spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

end
