//
//  StoryboardCustom_iOS7_Chapter_ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/27.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "StoryboardCustom_iOS7_Chapter_ViewController.h"

@interface StoryboardCustom_iOS7_Chapter_ViewController ()

@end

@implementation StoryboardCustom_iOS7_Chapter_ViewController

#pragma mark - Life Circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    NSLog(@"StoryboardCustom_iOS7_Chapter_ViewController viewDidLoad");
    
    self.view.backgroundColor = [UIColor purpleColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
    NSLog(@"StoryboardCustom_iOS7_Chapter_ViewController viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //
    NSLog(@"StoryboardCustom_iOS7_Chapter_ViewController viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //
    NSLog(@"StoryboardCustom_iOS7_Chapter_ViewController viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //
    NSLog(@"StoryboardCustom_iOS7_Chapter_ViewController viewDidDisappear");
}

@end
