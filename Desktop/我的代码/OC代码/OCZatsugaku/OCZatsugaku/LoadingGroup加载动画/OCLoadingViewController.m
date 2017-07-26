//
//  OCLoadingViewController.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/28.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "OCLoadingViewController.h"
#import "LKXSubmitLoadingView.h"
#import "LKXGlassesLoadingView.h"
#import "LKXWalkLoadingView.h"
#import "LKXArchLoadingView.h"
#import "LKXBoundcyPreloaderLoadingView.h"
#import "LKXZhiHuLoadingView.h"
#import "LKXTriangleLoadingView.h"
#import "LKXPacManLoadingView.h"

@interface OCLoadingViewController ()

/** 1 / 4 圆弧loading */
@property(nonatomic, strong) LKXSubmitLoadingView *submitLoading;
/** 三个点loading */
@property(nonatomic, strong) LKXGlassesLoadingView *glassesLoading;
/** 4个点loading */
@property(nonatomic, strong) LKXWalkLoadingView *walkLoading;
/** 类似wifi 动画 */
@property(nonatomic, strong) LKXArchLoadingView *archLoading;
/** 复制动画 */
@property(nonatomic, strong) LKXBoundcyPreloaderLoadingView *boundcyLoading;
/** 仿知乎动画 */
@property(nonatomic, strong) LKXZhiHuLoadingView *zhiHuLoading;
/** 三角动画 */
@property(nonatomic, strong) LKXTriangleLoadingView *triangleLoading;
/** 贪吃豆 */
@property(nonatomic, strong) LKXPacManLoadingView *pacManLoading;

@end

@implementation OCLoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _submitLoading = [[LKXSubmitLoadingView alloc] initWithFrame:CGRectMake(20, 84, 100, 100)];
    [_submitLoading startLoading];
    [self.view addSubview:_submitLoading];
    
    _glassesLoading = [[LKXGlassesLoadingView alloc] initWithFrame:CGRectMake(_submitLoading.lkx_right + 20, _submitLoading.lkx_top, _submitLoading.lkx_width, _submitLoading.lkx_height)];
    [_glassesLoading startLoading];
    [self.view addSubview:_glassesLoading];
    
    _walkLoading = [[LKXWalkLoadingView alloc] initWithFrame:CGRectMake(_glassesLoading.lkx_right + 20, _glassesLoading.lkx_top, _glassesLoading.lkx_width, _glassesLoading.lkx_height)];
    [_walkLoading startLoading];
    [self.view addSubview:_walkLoading];
    
    _archLoading = [[LKXArchLoadingView alloc] initWithFrame:CGRectMake(_submitLoading.lkx_left, _submitLoading.lkx_bottom + 20, _submitLoading.lkx_width, _submitLoading.lkx_height)];
    [_archLoading startLoading];
    [self.view addSubview:_archLoading];
    
    _boundcyLoading = [[LKXBoundcyPreloaderLoadingView alloc] initWithFrame:CGRectMake(_archLoading.lkx_right + 20, _archLoading.lkx_top, _archLoading.lkx_width, _archLoading.lkx_height)];
    [_boundcyLoading startLoading];
    [self.view addSubview:_boundcyLoading];
    
    _zhiHuLoading = [[LKXZhiHuLoadingView alloc] initWithFrame:CGRectMake(_boundcyLoading.lkx_right + 20, _boundcyLoading.lkx_top, _boundcyLoading.lkx_width, _boundcyLoading.lkx_height)];
    [_zhiHuLoading startLoading];
    [self.view addSubview:_zhiHuLoading];
    
    _triangleLoading = [[LKXTriangleLoadingView alloc] initWithFrame:CGRectMake(_archLoading.lkx_left, _archLoading.lkx_bottom + 20, _archLoading.lkx_width, _archLoading.lkx_height)];
    [_triangleLoading startLoading];
    [self.view addSubview:_triangleLoading];
    
    _pacManLoading = [[LKXPacManLoadingView alloc] initWithFrame:CGRectMake(_triangleLoading.lkx_right + 20, _triangleLoading.lkx_top, _triangleLoading.lkx_width, _triangleLoading.lkx_height)];
    [_pacManLoading startLoading];
    [self.view addSubview:_pacManLoading];
    
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4
//                                                      target:self
//                                                    selector:@selector(endAnimation)
//                                                    userInfo:nil
//                                                     repeats:NO];
    
//    _pacManLoading.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endAnimation {
    [_submitLoading stopLoading:nil];
    [_glassesLoading stopLoading:nil];
    [_walkLoading stopLoading:nil];
    [_archLoading stopLoading:nil];
    [_boundcyLoading stopLoading:nil];
    [_zhiHuLoading stopLoading:nil];
    [_triangleLoading stopLoading:nil];
    [_pacManLoading stopLoading:nil];
}

@end
