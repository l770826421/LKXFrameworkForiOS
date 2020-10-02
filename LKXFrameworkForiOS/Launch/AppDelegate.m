//
//  AppDelegate.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/4/19.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "AppDelegate.h"
#import <YKWoodpecker.h>

#import "LKXcardPassesViewController.h"
#import "LKXWKWebDemoViewController.h"
#import "LKXEstimatedRowHeightViewController.h"

#import "LKXTabBarController.h"
#import "NSObject+LKXRuntime.h"
#import "LKXRequestManager.h"
#import "LKXNavigationController.h"

#import "NSString+LKXEncryption.h"

#import "LKXUser.h"

#import "LKXKeychainTool.h"
#import "LKXEmailSendTool.h"

#define kRestoreApplicationStateKey @"kRestoreApplicationStateKey"

@interface AppDelegate ()

/** 用户进入后台的覆盖view */
@property(nonatomic, strong) UIImageView *splash;

@end

@implementation AppDelegate {
    LKXTabBarController *_tabBarController;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 参考网站 https://github.com/ZimWoodpecker/WoodpeckerCmdSource
    [YKWoodpeckerManager sharedInstance].cmdSourceUrl = @"https://raw.githubusercontent.com/ZimWoodpecker/WoodpeckerCmdSource/master/cmdSource/default/demo.json";
        
        // It's suggested to open 'safePluginMode' in release mode, so that only safe plugins can be open * Optional
    #ifndef DEBUG
        [YKWoodpeckerManager sharedInstance].safePluginMode = YES;
    #endif
        
        // Specify a 'parseDelegate' and you can realize custom commands via 'YKWCmdCoreCmdParseDelegate' * Optional
        [YKWoodpeckerManager sharedInstance].cmdCore.parseDelegate = self;
        
        // Show the woodpecker, the 'ViewPicker' plugin will be open on launch.
        [YKWoodpeckerManager sharedInstance].autoOpenUICheckOnShow = YES;
        [[YKWoodpeckerManager sharedInstance] show];
        
        // Register the crash handler to log crash * Optional
        [[YKWoodpeckerManager sharedInstance] registerCrashHandler];

        // Demo for registering a plugin * Optional
        [[YKWoodpeckerManager sharedInstance] registerPluginWithParameters:@{@"pluginName" : @"XXX",
                                                                             @"isSafePlugin" : @(NO),
                                                                             @"pluginInfo" : @"by user_XX",
                                                                             @"pluginCharIconText" : @"x",
                                                                             @"pluginCategoryName" : @"自定义",
                                                                             @"pluginClassName" : @"ClassName"}];
    
    // 测试
    [self appleUncaughtExceptionWithOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    _tabBarController = [[LKXTabBarController alloc] init];
    [self setTabBarControllerSubChildren];
    self.window.rootViewController = _tabBarController;
    
    [self objectForRuntime];
    LKXMLog(@"----%@---", NSStringFromSelector(@selector(objectForRuntime)));
    [self functionAndChainForProgram];
    
    [[LKXRequestManager shareRequestManager] categoryWithURL:@"http://apim.tp-shop.cn/index.php?m=Api&c=Goods&a=goodsCategoryList" success:^(NSDictionary *json) {
        LKXMLog(@"json = %@", json);
    } failure:^(NSString *message) {
        LKXMLog(@"message = %@", message);
    }];
    
    [self testC];
    
//    NSArray *arr = [NSArray array];
//    arr[0];
    
    NSString *account = [LKXKeychainTool readKeyChainValueWithKey:@"account" error:^(OSStatus errorStatus) {
        LKXMLog(@"读取账号失败:%d", errorStatus);
    }];
    
    NSString *password = [LKXKeychainTool readKeyChainValueWithKey:@"password" error:^(OSStatus errorStatus) {
        LKXMLog(@"读取密码失败:%d", errorStatus);
    }];
    
    LKXMLog(@"账号:%@, 密码:%@", account, password);
    
    // 给文件添加保护等级
    
    NSData *textData = [@"测试测试测试" dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSString *path = FILE_PATH_OF_DOCUMENT(@"test.txt");
    
    // 1.写入数据时设置保护等级
    [textData writeToFile:path
                  options:NSDataWritingFileProtectionComplete
                    error:&error];
    
    // 2.通过NSFileManager设置保护等级
    [[NSFileManager defaultManager] setAttributes:@{NSFileProtectionComplete : NSFileProtectionKey}
                                     ofItemAtPath:path
                                            error:&error];
    
    // 3.给数据库设置保护等级
//    sqlite3_open_v2([databasePath NSUTF8StringEncoding], &handle, SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE_SQLITE_OPEN_FILEPROTECTION_COMPLETEUNLESSOPEN, NULL);
    
    [self encryption];
    
//    [LKXEmailSendTool systemSendEmailWithRecipients:@[@"770826421@qq.com"] andCcRecipients:nil andBccRecipients:nil addTheme:@"测试" addBody:@"测试body"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 这里是进入后台屏幕遮挡
    application = [UIApplication sharedApplication];
    
    if (!self.splash) {
        UIImageView *splash = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [splash setImage:[UIImage imageNamed:@"sm.jpg"]];
        splash.userInteractionEnabled = NO;
        splash.alpha = 0.9;
        self.splash = splash;
    }
    [[application keyWindow] addSubview:self.splash];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (self.splash) {
        [self.splash removeFromSuperview];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    LKXMLog(@"APP关闭");
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    LKXMLog(@"open url:%@", url);
    NSString *urlString = url.absoluteString;
    if ([urlString hasSuffix:@"home"]) {
        _tabBarController.selectedIndex = 0;
    } else if ([urlString hasSuffix:@"webView"]) {
        _tabBarController.selectedIndex = 1;
    }  else if ([urlString hasSuffix:@"tableView"]) {
        _tabBarController.selectedIndex = 2;
    } else {
        return NO;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}

//- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
//    UIViewController *vc = [[UIViewController alloc] init];
//    return vc;
//}

//- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder {
//    NSMutableArray *viewcontrollers = [_tabBarController.viewControllers copy];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:viewcontrollers];
//    [coder encodeObject:data forKey:kRestoreApplicationStateKey];
//}
//
//
//- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder {
//    NSData *data = [coder decodeObjectForKey:kRestoreApplicationStateKey];
//    NSArray *viewControllers = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    _tabBarController.viewControllers = viewControllers;
//}

#pragma mark - other
- (void)setTabBarControllerSubChildren {
    LKXTabBarItemModel *cardPassesItem = [[LKXTabBarItemModel alloc] init];
    cardPassesItem.viewController = [[LKXcardPassesViewController alloc] init];
    cardPassesItem.title = @"一卡通";
    cardPassesItem.normalImage = [UIImage imageNamed:@"icon_home_normal"];
    cardPassesItem.selectedImage = [UIImage imageNamed:@"icon_home_hightlight"];
    [_tabBarController addChildViewControllerWithItem:cardPassesItem];
    
    LKXTabBarItemModel *wkWebItem = [[LKXTabBarItemModel alloc] init];
    wkWebItem.viewController = [[LKXWKWebDemoViewController alloc] init];
    wkWebItem.title = @"网页";
    wkWebItem.normalImage = [UIImage imageNamed:@"icon_web_normal"];
    wkWebItem.selectedImage = [UIImage imageNamed:@"icon_web_hightlight"];
    [_tabBarController addChildViewControllerWithItem:wkWebItem];
    
    
    LKXTabBarItemModel *personCenterItem = [[LKXTabBarItemModel alloc] initWithViewController:[LKXEstimatedRowHeightViewController class]
                                                                                        title:@"个人中心"
                                                                              normalImageName:@"icon_user_normal"
                                                                            selectedImageName:@"icon_user_hightlight"];
    [_tabBarController addChildViewControllerWithItem:personCenterItem];
}

/**
 runtime在字典转模型的应用
 */
- (void)objectForRuntime {
    [LKXUser lkx_propertyList];
    LKXUser *user =
    [LKXUser lkx_objectWithDictionary:@{
                                        @"name" : @"张三",
                                        @"age" : @12,
                                        @"hight" : @170,
                                        @"nickname" : @"大西瓜"
                                        }];
    LKXMLog(@"user = %@", user.description);
}

/**
 函数编程和链式编程
 */
- (void)functionAndChainForProgram {
    LKXUser *user = [[LKXUser alloc] init];
    // 链式编程
    // 1.传统的写法
    // 1> run和eat需要单独调用
    // 2> 不能随意组合顺序
    [user run];
    [user eat];
    
    // 2.可以连续调用
    // 例如: [[user run] eat];
    [[user run1] eat1];
    
    // 3.函数式编程
    // 在OC中什么时候会用到'()' -> 执行'block需要()'
    user.run2().eat2();
    

    user.run3(100).eat3(@"water").run3(1000).eat3(@"wind");
}

- (void)testC {
    int a[5] = {1, 2, 3, 4, 5};
    int *ptr = (int *)(&a + 1);
    printf("%d %d %d %d", *a, *(a + 1), *(ptr - 1), *(ptr + 1));
}

void UncaughtExceptionHandler(NSException *exception) {
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的
    // 例如下面的symbols数组就是我们的崩溃堆栈。
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    LKXNLog(@"APP crash, name: %@ \n reason: %@ \n callStackSymbols: %@", name, reason, symbols);
    abort();
}

- (void)appleUncaughtExceptionWithOptions:(NSDictionary *)launchOptions {
    // 注册异常处理函数
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    // 获取奔溃统计的函数指针
//    NSUncaughtExceptionHandler *handler = NSGetUncaughtExceptionHandler();
//    LKXNLog(@"奔溃统计的函数指针: %@", handler);
}

- (void)encryption {
    NSString *plainText = @"我是明文";
    NSString *cipherText = nil;
    
    // MD5
    cipherText = [plainText lkx_MD5Encrypt];
    LKXMLog(@"MD5: %@", cipherText);
    
    // sha1
    cipherText = [plainText lkx_SHA1Encrypt];
    LKXMLog(@"SHA1密文: %@", cipherText);
    
    // sha224
    cipherText = [plainText lkx_SHA224Encrypt];
    LKXMLog(@"SHA224密文: %@", cipherText);
    
    // sha256
    cipherText = [plainText lkx_SHA256Encrypt];
    LKXMLog(@"SHA256密文: %@", cipherText);
    
    // sha384
    cipherText = [plainText lkx_SHA384Encrypt];
    LKXMLog(@"SHA384密文: %@", cipherText);
    
    // SHA512
    cipherText = [plainText lkx_SHA512Encrypt];
    LKXMLog(@"SHA512密文: %@", cipherText);
    
    // DES
    NSString *key = @"刘克邪lkx";
    NSString *text = nil;
    cipherText = [plainText lkx_DESEncryptionWithEncryptOrDecryptOperation:kCCEncrypt key:key];
    LKXMLog(@"DES密文: %@", cipherText);
    text = [cipherText lkx_DESEncryptionWithEncryptOrDecryptOperation:kCCDecrypt key:key];
    LKXMLog(@"DES明文: %@", text);
    
    LKXMLog(@"------------------------");
    
    // AES
    cipherText = [plainText lkx_AES256EncryptWithKey:key];
    LKXMLog(@"AES密文: %@", cipherText);
    text = [cipherText lkx_AES256DecryptWithKey:key];
    LKXMLog(@"AES明文: %@", text);
}

- (void)htmlFunc {
    NSString *pdfFolder = [[[NSBundle mainBundle] pathForResource:@"HTML.bundle" ofType:nil] stringByAppendingPathComponent:@"html"];
    
    NSError *error = nil;
    NSArray *dirArr = [kFileManager contentsOfDirectoryAtPath:pdfFolder error:&error];
    NSMutableArray *files = [NSMutableArray arrayWithCapacity:3];
    for (NSString *filename in dirArr) {
        [files addObject:[pdfFolder stringByAppendingPathComponent:filename]];
    }
    LKXMLog(@"%@", files);
}

@end
