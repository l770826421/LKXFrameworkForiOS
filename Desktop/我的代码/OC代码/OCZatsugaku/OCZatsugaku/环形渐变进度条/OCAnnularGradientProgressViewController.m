//
//  OCAnnularGradientProgressViewController.m
//  OCZatsugaku
//
//  Created by lkx on 2017/6/23.
//  Copyright © 2017年 lkx. All rights reserved.
//

#import "OCAnnularGradientProgressViewController.h"
#import "LKXAnnularGradientProgressView.h"

@interface OCAnnularGradientProgressViewController ()

@property (weak, nonatomic) IBOutlet LKXAnnularGradientProgressView *annularView;
@end

@implementation OCAnnularGradientProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _annularView.persentage = 0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)progressAction:(UISlider *)sender {
    _annularView.persentage = sender.value;
}


@end
