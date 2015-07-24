//
//  Section9_1ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section9_1ViewController.h"
//
#import "CircleView.h"

@interface Section9_1ViewController ()

@property (weak, nonatomic) UIView *circleView;

@end

@implementation Section9_1ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"View Animation";
    
    CircleView *circleView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.circleView = circleView;
    circleView.center = CGPointMake(100, 20);
    [self.view addSubview:circleView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dropAnimate:)];
    [self.view addGestureRecognizer:g];
}

- (void)dropAnimate:(UIGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:3 animations:^{
        recognizer.enabled = NO;
        self.circleView.center = CGPointMake(100, 300);
    } completion:^(BOOL finished){
        #warning 如果动画还在进行的时候，再次触屏幕会结束动画，finished=NO，原来在completion中的代码就会提前执行。
        [UIView animateWithDuration:1 animations:^{
            self.circleView.center = CGPointMake(250, 300);
        } completion:^(BOOL finished){
            self.circleView.center = CGPointMake(100, 20);
            recognizer.enabled = YES;
        }];
    }];
}

@end
