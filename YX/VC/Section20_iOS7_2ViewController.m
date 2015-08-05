//
//  Section20_iOS7_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section20_iOS7_2ViewController.h"
#import "Section20_iOS7_3ViewController.h"
//
#import "YXVCTransitioningDelegate.h"
#import "YXPercentDrivenAnimation.h"

@interface Section20_iOS7_2ViewController ()

@property (strong, nonatomic) YXPercentDrivenAnimation *animation;

@end

@implementation Section20_iOS7_2ViewController

- (void)loadView
{
    [super loadView];
    //
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(12, 20, 60, 44);
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
    pushButton.frame = CGRectMake(0, 0, 100, 50);
    pushButton.center = self.view.center;
    [pushButton setTitle:@"Push" forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    //
    self.animation = [[YXPercentDrivenAnimation alloc] init];
    [self.animation wireToViewController:self];
    
    YXVCTransitioningDelegate *transition = self.navigationController.transitioningDelegate;
    transition.dismissPercentDriven = self.animation;
}

#pragma mark - Action

- (void)closePage:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pushPage:(UIButton *)sender
{
    Section20_iOS7_3ViewController *vc = [[Section20_iOS7_3ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
