//
//  Section9_6ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section9_6ViewController.h"
//
#import "CircleCALayer.h"

@interface Section9_6ViewController ()

@property (weak, nonatomic) CircleCALayer *circleLayer;

@end

@implementation Section9_6ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"实现自动动画";
    
    CircleCALayer *circleLayer = [CircleCALayer new];
    self.circleLayer = circleLayer;
    circleLayer.radius = 20;
    circleLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:circleLayer];
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.duration = 2;
    
    CABasicAnimation *fadeAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnim.fromValue = [NSNumber numberWithDouble:0.4];
    fadeAnim.toValue = [NSNumber numberWithDouble:1.0];
    
    CABasicAnimation *growAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    growAnim.fromValue = [NSNumber numberWithDouble:0.8];
    growAnim.toValue = [NSNumber numberWithDouble:1.0];
    
    CAAnimationGroup *groupAnim = [CAAnimationGroup animation];
    groupAnim.animations = [NSArray arrayWithObjects:fadeAnim, growAnim, nil];
    
    NSMutableDictionary *actions = [NSMutableDictionary dictionaryWithDictionary: [circleLayer actions]];
    [actions setObject:anim forKey:@"position"];
    [actions setObject:groupAnim forKey:kCAOnOrderIn];
    circleLayer.actions = actions;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    UIGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:g];
}

- (void)tap:(UIGestureRecognizer *)recognizer
{
    CircleCALayer *circleLayer = (CircleCALayer*)[self.view.layer.sublayers objectAtIndex:0];
    [circleLayer setPosition:CGPointMake(100, 100)];
    [CATransaction setAnimationDuration:2];
    [circleLayer setRadius:100.0];
}

@end
