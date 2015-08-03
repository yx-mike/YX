//
//  Section19_iOS7_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_2ViewController.h"
//
#import "Macros.h"

@interface Section19_iOS7_2ViewController ()

@property (weak, nonatomic) UIView *testView;
@property (weak, nonatomic) UIView *attachView;
@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@end

@implementation Section19_iOS7_2ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"附着";
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.testView = testView;
    testView.center = CGPointMake(FullScreenWidth/2.0, FullScreenHeight/2.0);
    testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testView];
    
    UIView *attachView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.attachView = attachView;
    attachView.center = CGPointMake(FullScreenWidth/2.0, 25);
    attachView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:attachView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //
    UIDynamicAnimator *dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.dynamicAnimator = dynamicAnimator;
    
    //附着会使视图绕着锚点打转，加上多个附着行为可以阻止这个
    UIAttachmentBehavior *attach1 = [[UIAttachmentBehavior alloc] initWithItem:self.testView offsetFromCenter:UIOffsetMake(25, 25) attachedToAnchor:self.testView.center];
    [dynamicAnimator addBehavior:attach1];
    
    UIAttachmentBehavior *attach2 = [[UIAttachmentBehavior alloc] initWithItem:self.attachView attachedToItem:self.testView];
    [dynamicAnimator addBehavior:attach2];
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.attachView] mode:UIPushBehaviorModeInstantaneous];
    push.pushDirection = CGVectorMake(0, 2);
    [dynamicAnimator addBehavior:push];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //
    [self.dynamicAnimator removeAllBehaviors];
}

@end
