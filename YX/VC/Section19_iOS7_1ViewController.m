//
//  Section19_iOS7_1ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/2.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_1ViewController.h"

@interface Section19_iOS7_1ViewController ()

@property (weak, nonatomic) UIView *testView;

@end

@implementation Section19_iOS7_1ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"迅速移动";
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.testView = testView;
    testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.testView snapToPoint:CGPointMake(160, 400)];
    snap.damping = 1;
    
    UIDynamicAnimator *dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [dynamicAnimator addBehavior:snap];
    [dynamicAnimator performSelector:@selector(removeBehavior:) withObject:snap afterDelay:1];
}

@end
