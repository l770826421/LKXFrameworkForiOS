//
//  LKXUserExports.h
//  LKXFrameworkForiOS
//
//  Created by lkx on 4/6/2019.
//  Copyright © 2019 刘克邪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LKXUserExports <JSExport>

// 暴露的变量
@property NSString *address;

// 暴露的函数
- (NSString *)updateUser:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
