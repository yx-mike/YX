//
//  Section9_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section9_2ViewController.h"
//
#import "DelegateView.h"
//
#import "Macros.h"

@interface Section9_2ViewController ()

@property (weak, nonatomic) UIView *caLayerView;

@end

@implementation Section9_2ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"CALayer";
    
    UIImage *image = [UIImage imageNamed:@"Pushing"];
    self.view.layer.contents = (__bridge id)[image CGImage];
    self.view.layer.contentsGravity = kCAGravityCenter;
    #warning 注意retain屏幕要设置scale
    self.view.layer.contentsScale = image.scale;
    
    UIView *delegateView = [[DelegateView alloc] initWithFrame:CGRectMake(0, 0, FullkScreenWidth, 60)];
    [self.view addSubview:delegateView];
}

@end
