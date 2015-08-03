//
//  Section19_iOS7_3ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_3ViewController.h"

@interface Section19_iOS7_3ViewController ()

@property (weak, nonatomic) UIView *testView;
@property (weak, nonatomic) UIView *gravityView;
@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;

@end

@implementation Section19_iOS7_3ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"推力、重力";
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.testView = testView;
    testView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:testView];
    
    UIView *gravityView = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
    self.gravityView = gravityView;
    gravityView.backgroundColor = [UIColor redColor];
    [self.view addSubview:gravityView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //
    UIDynamicAnimator *dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.dynamicAnimator = dynamicAnimator;
    
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.testView] mode:UIPushBehaviorModeContinuous];
    push.pushDirection = CGVectorMake(1.8, 2.8);
    [self.dynamicAnimator addBehavior:push];
    [dynamicAnimator performSelector:@selector(removeBehavior:) withObject:push afterDelay:1.8];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.gravityView]];
    gravity.action = ^{
        NSLog(@"gravityView.center:%@", NSStringFromCGPoint(self.gravityView.center));
    };
    [self.dynamicAnimator addBehavior:gravity];
    [dynamicAnimator performSelector:@selector(removeBehavior:) withObject:gravity afterDelay:1.8];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.testView, self.gravityView]];
    [self.dynamicAnimator addBehavior:collision];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //
    [self.dynamicAnimator removeAllBehaviors];
}

@end
