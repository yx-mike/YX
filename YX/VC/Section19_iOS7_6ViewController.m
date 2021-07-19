//
//  Section19_iOS7_6ViewController.m
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_6ViewController.h"

#import "YXMotionDynamicMaker.h"


@interface Section19_iOS7_6ViewController ()

@property (nonatomic, weak) UIView *dynamicView;

@property (nonatomic, strong) YXMotionDynamicMaker *motionDynamicMaker;

@end

@implementation Section19_iOS7_6ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect bounds = self.view.bounds;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    rect.size.width = bounds.size.width - 0;
    rect.size.height = bounds.size.height - 34;
    UIView *dynamicView = [[UIView alloc] initWithFrame:rect];
    dynamicView.backgroundColor = [UIColor lightGrayColor];
    self.dynamicView = dynamicView;
    [self.view addSubview:dynamicView];
    
    
    self.motionDynamicMaker = [[YXMotionDynamicMaker alloc] initWithView:self.dynamicView];
    [self.motionDynamicMaker loadItems];
    [self.motionDynamicMaker startMotion];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.motionDynamicMaker stopMotion];
}

@end
