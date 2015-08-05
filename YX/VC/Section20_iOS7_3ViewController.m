//
//  Section20_iOS7_3ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section20_iOS7_3ViewController.h"

@interface Section20_iOS7_3ViewController ()

@end

@implementation Section20_iOS7_3ViewController

- (void)loadView
{
    [super loadView];
    //
    
    UIButton *popButton = [UIButton buttonWithType:UIButtonTypeSystem];
    popButton.frame = CGRectMake(0, 0, 100, 50);
    popButton.center = self.view.center;
    [popButton setTitle:@"Pop" forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor purpleColor];
}

#pragma mark - Action

- (void)popPage:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
