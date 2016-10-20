//
//  LKXcardPassesViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 16/10/19.
//  Copyright © 2016年 刘克邪. All rights reserved.
//

#import "LKXcardPassesViewController.h"

#import "Masonry.h"

@interface LKXcardPassesViewController ()

@end

@implementation LKXcardPassesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self autolayoutScroll];
    self.scroll.backgroundColor = [UIColor greenColor];
    __weak typeof(self) selfWeak = self;
    
    UIView *container = [[UIView alloc] init];
    container.backgroundColor = [UIColor brownColor];
    [self.scroll addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(selfWeak.scroll);
        make.width.equalTo(selfWeak.scroll);
    }];
    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [container addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.width.equalTo(container);
        make.height.equalTo(@150);
    }];
    
    /**  两个并排的view */
    CGFloat padding = 10;
    UIView *subWhiteView = [[UIView alloc] init];
    subWhiteView.backgroundColor = [UIColor whiteColor];
    [redView addSubview:subWhiteView];
    
    UIView *subBlackView = [[UIView alloc] init];
    subBlackView.backgroundColor = [UIColor blackColor];
    [redView addSubview:subBlackView];
    
    __weak __typeof(redView) redViewWeak = redView;
    __weak __typeof(subWhiteView) subWhiteViewWeak = subWhiteView;
    __weak __typeof(subBlackView) subBlackViewWeak = subBlackView;
    [subWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(redViewWeak.mas_centerY);
        make.left.equalTo(redViewWeak.mas_left).with.offset(padding);
        make.right.equalTo(subBlackViewWeak.mas_left).with.offset(-padding);
        make.width.equalTo(subBlackViewWeak);
        make.height.equalTo(redViewWeak.mas_height);
    }];
    
    [subBlackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(redViewWeak.mas_centerY);
        make.left.equalTo(subWhiteViewWeak.mas_right).with.offset(padding);
        make.right.equalTo(redViewWeak.mas_right).with.offset(-padding);
        make.width.equalTo(subWhiteViewWeak);
        make.height.equalTo(redViewWeak.mas_height);
    }];
    
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [container addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView.mas_bottom).with.offset(padding);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.height.equalTo(@200);
    }];
    
    UIView *blueView = [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    [container addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_bottom).with.offset(padding);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.height.equalTo(@200);
    }];
    
    UIView *blackView = [[UIView alloc] init];
    blackView.backgroundColor = [UIColor blackColor];
    [container addSubview:blackView];
    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(blueView.mas_bottom).with.offset(padding);
        make.left.equalTo(container);
        make.right.equalTo(container);
        make.height.equalTo(@200);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(blackView.mas_bottom);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

 In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
