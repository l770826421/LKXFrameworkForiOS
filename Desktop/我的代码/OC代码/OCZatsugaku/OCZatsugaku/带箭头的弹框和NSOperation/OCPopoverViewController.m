//
//  OCPopoverViewController.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/22.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "OCPopoverViewController.h"
#import "OCPresentdViewController.h"

@interface OCPopoverViewController () <UIPopoverPresentationControllerDelegate>
/**
 要弹出来的VC
 */
@property(nonatomic, strong) OCPresentdViewController *presentedVC;
/**
 带箭头的弹出框
 */
@property(nonatomic, weak) UIPopoverPresentationController *popoverContreller;
@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@end

@implementation OCPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)p_popverAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
//        if (!_presentedVC) {
            _presentedVC = [[OCPresentdViewController alloc] init];
            _presentedVC.modalPresentationStyle = UIModalPresentationPopover;
            _presentedVC.preferredContentSize = CGSizeMake(300, 100);
//        }
        
        if (!_popoverContreller) {  // 在dismiss时会kill
            _popoverContreller = _presentedVC.popoverPresentationController;
            // 弹出时的所参照的视图,与弹框有关的位置有关
            _popoverContreller.sourceView = sender;
            // 弹出时的所参照视图的大小，与弹框的位置有关
            _popoverContreller.sourceRect = sender.bounds;
            // 弹框的箭头方向
            _popoverContreller.permittedArrowDirections = UIPopoverArrowDirectionAny;
            _popoverContreller.delegate = self;
            _popoverContreller.backgroundColor = [UIColor redColor];
        }
        
        [self presentViewController:_presentedVC
                           animated:YES
                         completion:nil];
    } else {
        [_presentedVC dismissViewControllerAnimated:YES
                                         completion:nil];
    }
}

#pragma mark - UIPopoverPresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    _showBtn.selected = NO;
    return YES;
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    
}

@end
