#
#  Be sure to run `pod spec lint LKXFrameworkForiOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "LKXFrameworkForiOS"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of LKXFrameworkForiOS."
  spec.description  = <<-DESC
  我自己写的一个项目常用的oc类扩展和工具类
                   DESC
  spec.homepage     = "https://github.com/l770826421/LKXFrameworkForiOS.git"
  spec.license      = "MIT"
  spec.author             = { "l770826421" => "770826421@qq.com" }
  spec.ios.deployment_target = "9.0"
  spec.source       = { :git => "https://github.com/l770826421/LKXFrameworkForiOS.git", :tag => "#{spec.version}" }
  spec.source_files  = "LKXFrameworkForiOS/Classes/Expand/**/*.{h,m}"

  # spec.requires_arc = true

end
