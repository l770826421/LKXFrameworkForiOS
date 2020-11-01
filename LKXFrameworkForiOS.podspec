#
#  Be sure to run `pod spec lint LKXFrameworkForiOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "LKXFrameworkForiOS"
  spec.version      = "1.0.1"
  spec.summary      = "将常见的方法、功能集成起来."
  spec.description  = <<-DESC
  将常见的方法、功能集成起来:
  1. Foundation的类扩展
  2. UIKit的类扩展
  3. 黑魔法使用
  4. 权限查询
  5. 设备信息
  6. 。。。
                   DESC

  spec.homepage     = "https://github.com/l770826421/LKXFrameworkForiOS.git"
  spec.license      = "MIT"


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "KexieLiu" => "770826421@qq.com" }
  # Or just: spec.author    = "kexieliu"
  # spec.authors            = { "kexieliu" => "kxliul@isoftstone.com" }
  # spec.social_media_url   = "https://twitter.com/kexieliu"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # spec.platform     = :ios
  spec.platform     = :ios, "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #
  #项目的真实地址，pod 就根据这个来导入的
  # spec.source       = { :git => "https://github.com/l770826421/LKXFrameworkForiOS.git", :tag => spec.version.to_s }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #
  # 暴露的文件
  spec.source_files  = "LKXFrameworkForiOS", "LKXFrameworkForiOS/Classes/Expand/**/*.{h,m}"
  #spec.exclude_files = "LKXFrameworkForiOS/Exclude"
  
  #pch文件
    spec.prefix_header_file = "LKXFrameworkForiOS/Classes/Expand/LKXCommonFile/CommonTool/Macros_UICommon.h"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #
  # 暴露资源
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #
  # 依赖的库
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"
  #spec.frameworks= "UIKit", "Foundation", "JavaScriptCore", "objc", "QuartzCore", "CommonCrypto", "AVFoundation", "CoreTelephony", "CoreLocation", "EventKit", "Photos", "AssetsLibrary", "AddressBook", "Contacts", "MessageUI", "LocalAuthentication", "CoreLocation", "CoreBluetooth", "LocalAuthentication"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # 是否要求项目是否ARC
  spec.requires_arc = false

  # y依赖的系统库，和第三方哭
  spec.dependency 'SDWebImage', '~> 5.8.3'
  spec.dependency 'AFNetworking', '~> 4.0.1'
  spec.dependency 'MJRefresh', '~> 3.4.3'
  spec.dependency 'MJExtension', '~> 3.2.2'
  spec.dependency 'MBProgressHUD', '~> 1.2.0'
  spec.dependency 'SDCycleScrollView', '~> 1.80'
  spec.dependency 'Masonry', '~> 1.1.0'
  spec.dependency 'Reachability', '~> 3.2'
  spec.dependency 'YKWoodpecker', '~> 1.2.8'

end
