//
//  Section9_5ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section9_5ViewController.h"

@interface Section9_5ViewController ()

@end

@implementation Section9_5ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"美化图层";
    //
    CALayer *layer;
    layer = [CALayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.cornerRadius = 10;
    layer.backgroundColor = [[UIColor redColor] CGColor];
    layer.borderColor = [[UIColor blueColor] CGColor];
    layer.borderWidth = 5;
    layer.shadowOpacity = 0.5;
    layer.shadowOffset = CGSizeMake(3.0, 3.0);
    [self.view.layer addSublayer:layer];
    
    layer = [CALayer layer];
    layer.frame = CGRectMake(150, 150, 100, 100);
    layer.cornerRadius = 10;
    layer.backgroundColor = [[UIColor greenColor] CGColor];
    layer.borderWidth = 5;
    layer.shadowOpacity = 0.5;
    layer.shadowOffset = CGSizeMake(3.0, 3.0);
    [self.view.layer addSublayer:layer];
}

@end
