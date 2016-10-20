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
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.scroll addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selfWeak.scroll);
        make.left.equalTo(selfWeak.scroll);
        make.right.equalTo(selfWeak.scroll);
        make.width.equalTo(selfWeak.scroll.mas_width);
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
