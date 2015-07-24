//
//  YXMutiTableViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/18.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXMutliTableViewController.h"
//
#import "YXMultiSubTableViewController.h"

@interface YXMutliTableViewController ()

@property (weak, nonatomic) UIViewController *currentChildViewController;

@end

@implementation YXMutliTableViewController

- (void)loadView
{
    [super loadView];
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(tap)];
    //
    YXMultiSubTableViewController *tapNo1 = [[YXMultiSubTableViewController alloc] initWithFrame:self.view.frame];
    tapNo1.title = @"第一个";
    [self addChildViewController:tapNo1];
    
    [self.view addSubview:tapNo1.view];
    self.title = @"第一个表视图";
    self.currentChildViewController = tapNo1;
    
    YXMultiSubTableViewController *tapNo2 = [[YXMultiSubTableViewController alloc] initWithFrame:self.view.frame];
    tapNo2.title = @"第二个";
    [self addChildViewController:tapNo2];
}

#pragma mark - actions

- (void)tap
{
    UIViewController *toVC = self.childViewControllers[0];
    NSString *title = @"第一个表视图";
    if (self.currentChildViewController == self.childViewControllers[0]) {
        toVC = self.childViewControllers[1];
        title = @"第二个表视图";
    }
    
    [self transitionFromViewController:self.currentChildViewController
                      toViewController:toVC
                              duration:1.0
                               options:UIViewAnimationOptionTransitionFlipFromLeft
                            animations:^{}
                            completion:^(BOOL completion){
                                self.title = title;
                                self.currentChildViewController = toVC;
                            }];
}

@end
