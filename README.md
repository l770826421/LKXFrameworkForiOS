# LKXFrameworkForiOS
 这是将常用的一些基础知识写成了一个框架，只包含一些第三库的使用，或者常用的系统操作。
 1. 目录结构
 1.1 Lanunch:系统原文件,AppDelegate、main、storyboard、base.lproj、Assets.xcassets文件
 
 1.2 项目中自定义文件目录
 1.2.1 Until(工具类): 自己写的工具类,MVC结构，
   ViewController:
   1> LKXTabBarController:自定义TabBarController
   2> LKXNavigationController: 自定义NavigationController
   3> LKXBaseViewController： UIViewController的包装,集成项目的常用方法
   4> LKXScrollViewController：继承LKXBaseViewController，并实例化ScrollView，添加上下拉加载
   5> LKXTableViewController/LKXCollectionViewController/LKXWebViewController/LKXWKWebViewController: 集成LKXScrollViewController，示例化各自的代理方法
   View:
     1>LKXTabBar（自定义tabbar）、LKXTabBarButton
     2>LKXWebProgressView:WKWebView进度条
     3>LKXReloadView:空白加载页面
     4>LKXTableViewCell:自定义UITableCell,添加一个tableView注册cell的类方法,和在实例化栅格化、异步绘制代码，可以根据实际需求是否使用.
1.2.2 LKXCommonFile:扩展系统常用的方法
  1> category:类扩展:包括NSString、NSArray、NSMutableAttributedString、NSDate、NSData、UIView、UINavigationController的类扩展
  2> CommonTool:常用方法的继承，扩展新的方法
  4> tool：继承iPhone常用功能的集成，相册相机、Alert、日历、设备权限、项目信息、邮件发送、指纹验证、常用第三方功能封装
1.2.3 NetWorking：AFNetworking封装
  
1.3 Modules(功能模块):项目功能
   1.3.1 Home: Masonry的在Scroll下的使用,Alert、指纹验证、日历工具类使用
   
1.4 OpenSource(开源文件)

1.5 Resource(本地文件):需要添加到项目中的文件
      
 
