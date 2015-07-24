//
//  Section9_3ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section9_3ViewController.h"

@interface Section9_3ViewController ()

@end

@implementation Section9_3ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"CALayerAnimation";
    
    CALayer *squareLayer = [CALayer layer];
    squareLayer.backgroundColor = [[UIColor redColor] CGColor];
    squareLayer.frame = CGRectMake(100, 100, 20, 20);
    [self.view.layer addSublayer:squareLayer];
    
    UIView *squareView = [UIView new];
    squareView.backgroundColor = [UIColor blueColor];
    squareView.frame = CGRectMake(200, 100, 20, 20);
    [self.view addSubview:squareView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    [self.view addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drop:)]];
}

- (void)drop:(UIGestureRecognizer *)recognizer
{
    #warning 改变CALayer隐式动画
    [CATransaction setAnimationDuration:2.0];
//    [CATransaction setDisableActions:YES];
    
    NSArray *layers = self.view.layer.sublayers;
    CALayer *layer = [layers objectAtIndex:0];
    CGPoint toPoint = CGPointMake(200, 250);
    [layer setPosition:toPoint];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = [NSNumber numberWithDouble:1.0];
    anim.toValue = [NSNumber numberWithDouble:0.0];
//    anim.autoreverses = YES;
//    anim.repeatCount = INFINITY;
    anim.duration = 2.0;
    [layer addAnimation:anim forKey:@"anim"];
    
    NSArray *views = self.view.subviews;
    UIView *view = [views objectAtIndex:0];
    [view setCenter:CGPointMake(100, 250)];
}

@end
