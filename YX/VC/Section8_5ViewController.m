//
//  Section8_5ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/19.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section8_5ViewController.h"

@interface Section8_5ViewController ()

@property (weak, nonatomic) UILabel *blurryLabel;

@end

@implementation Section8_5ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"像素对齐";
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(14, 20, 80, 40)];
    label1.text = @"Static:";
    [self.view addSubview:label1];
    
    UILabel *valueLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 100, 40)];
    valueLabel1.text = @"Some Text";
    [self.view addSubview:valueLabel1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(14, 80, 80, 40)];
    label2.text = @"Toggles:";
    [self.view addSubview:label2];
    
    UILabel *valueLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 100, 40)];
    self.blurryLabel = valueLabel2;
    valueLabel2.text = @"Some Text";
    [self.view addSubview:valueLabel2];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    btn.center = CGPointMake(160, 280);
    [btn setTitle:@"Toggle BLur" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - Target Mark

- (void)toggle:(UIButton *)sender
{
    #warning 像素点对齐问题
    CGRect frame = self.blurryLabel.frame;
    if (frame.origin.x == floor(frame.origin.x)) {
        frame.origin.x += 1.25;
    }
    else {
        frame.origin.x = floorf(frame.origin.x);
    }
    self.blurryLabel.frame = frame;
}

@end
