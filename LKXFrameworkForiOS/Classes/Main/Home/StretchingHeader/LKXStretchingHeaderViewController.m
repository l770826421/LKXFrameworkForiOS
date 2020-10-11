//
//  LKXStretchingHeaderViewController.m
//  LKXFrameworkForiOS
//
//  Created by lkx on 2017/11/15.
//  Copyright © 2017年 刘克邪. All rights reserved.
//

#import "LKXStretchingHeaderViewController.h"
#import "LKXEstimatedRowHeightCell.h"

#import "NSTimer+LKXWeakTime.h"
#import "Macros_UICommon.h"
#import "UIView+Common.h"

#define kHeaderHeight 220

@interface LKXStretchingHeaderViewController ()

/** 定时器 */
@property(nonatomic, strong) NSTimer *timer;

@end

@implementation LKXStretchingHeaderViewController {
    UIView              *_headerView;
    UIImageView         *_headerIV;
    UIStatusBarStyle    _statusBarStyle;
    UIView              *_lineView;
}

- (void)dealloc {
    NSLog(@"LKXStretchingHeaderViewController dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
    self.timer = [NSTimer scheduledWeakTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(testTimer)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)testTimer {
    NSLog(@"testTimer");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.lkx_width, kHeaderHeight)];
    _headerView.backgroundColor = kAPPMainColor;
    [self.view addSubview:_headerView];
    
    _headerIV = [[UIImageView alloc] initWithFrame:_headerView.bounds];
    _headerIV.image = [UIImage imageNamed:@"dragonfly.jpg"];
    _headerIV.contentMode = UIViewContentModeScaleAspectFill;
    _headerIV.clipsToBounds = YES;
    [_headerView addSubview:_headerIV];
    
    // 仿UINavigationBar的线
    CGFloat height = 1 / [UIScreen mainScreen].scale;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _headerView.lkx_height - height, _headerView.lkx_width, height)];
    _lineView.backgroundColor = [UIColor redColor];
    [_headerView addSubview:_lineView];
    
    self.tableView.frame = self.view.bounds;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    _statusBarStyle = UIStatusBarStyleLightContent;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarStyle;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LKXEstimatedRowHeightCell *cell = [LKXEstimatedRowHeightCell cellWithTableView:tableView];
    cell.src = [NSString stringWithFormat:@"%zd", indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;
//    LKXMLog(@"offset = %f", offset);
    if (offset <= 0) {
        _headerView.lkx_height = kHeaderHeight - offset;
        _headerIV.alpha = 1;
    } else {
        _headerView.lkx_height = kHeaderHeight;
        CGFloat min = kHeaderHeight - 64;
        _headerView.lkx_y = -MIN(min, offset);
        
        CGFloat progress = 1 - (offset / min);
        _headerIV.alpha = progress;
        LKXMLog(@"offset / min = %f", offset / min);
        
        _statusBarStyle =  progress < 0.5 ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    _headerIV.lkx_height = _headerView.lkx_height;
    _lineView.lkx_y = _headerView.lkx_height - _lineView.lkx_height;
}

@end
