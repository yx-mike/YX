//
//  Section20_iOS7_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section20_iOS7_2ViewController.h"

@interface Section20_iOS7_2ViewController ()

@end

@implementation Section20_iOS7_2ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"VC1";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(closeVC)];
}

#pragma mark - Target

- (void)closeVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
