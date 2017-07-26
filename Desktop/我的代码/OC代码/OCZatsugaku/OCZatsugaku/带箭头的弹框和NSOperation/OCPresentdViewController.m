//
//  OCPresentdViewController.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/22.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "OCPresentdViewController.h"
// NSOperation的自身状态:isReady -> isExecuting -> isFinish
// 取消 -(void)cancel;
// 优先级:threadPriority

@interface OCPresentdViewController ()

@end

@implementation OCPresentdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    // 如果直接调用operation的start方法，是在主线程上运行，不会开启新的线程。
    NSInvocationOperation *invocationOp =
        [[NSInvocationOperation alloc] initWithTarget:self
                                             selector:@selector(operationAction:)
                                               object:@"invocationOp"];
    [invocationOp start];
    
    // 在主线程中使用NSBlockOperation
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self operationAction:@"blockOperationForMainQueue"];
    }];
    
    // 使用NSOperationQueue管理NSOperation并开启一个异步线程
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    // 在队列中调用NSInvocationOperation
    NSInvocationOperation *invocationOpForQueue =
        [[NSInvocationOperation alloc] initWithTarget:self
                                             selector:@selector(operationAction:)
                                               object:@"invocationOpForQueue"];
    [operationQueue addOperation:invocationOpForQueue];
    
    //使用NSOperationQueue管理并NSBlockOperation开启一个线程
    NSBlockOperation *blockOpertaionForQueue = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction:@"blockOpertaionForQueue"];
    }];
    [operationQueue addOperation:blockOpertaionForQueue];
    
    
    // 添加依赖
    NSBlockOperation *blockOPeration1 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction:@"blockOPeration1"];
    }];
    
    // 添加依赖
    NSBlockOperation *blockOPeration2 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction:@"blockOPeration2"];
    }];
    
    // 添加依赖
    NSBlockOperation *blockOPeration3 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction:@"blockOPeration3"];
    }];
    // 添加依赖
    NSBlockOperation *blockOPeration4 = [NSBlockOperation blockOperationWithBlock:^{
        [self operationAction:@"blockOPeration4"];
    }];
    
    [blockOPeration2 addDependency:blockOPeration1];
    [blockOPeration3 addDependency:blockOPeration2];
    [blockOPeration4 addDependency:blockOPeration1];
    
    [operationQueue addOperation:blockOPeration4];
    [operationQueue addOperation:blockOPeration2];
    [operationQueue addOperation:blockOPeration3];
    [operationQueue addOperation:blockOPeration1];
    
    // NSOperation完成代码
    blockOPeration1.completionBlock = ^{
        NSLog(@"blockOPeration1完成");
    };
    
    blockOPeration4.completionBlock = ^{
        NSLog(@"blockOPeration4完成");
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)operationAction:(id)obj {
    NSLog(@"id = %@", obj);
}

@end
