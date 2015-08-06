//
//  YXPopVCCubeAnimation.m
//  YX
//
//  Created by 杨鑫 on 15/8/6.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXPopVCCubeAnimation.h"

@interface YXPopVCCubeAnimation ()

@property (strong, nonatomic) id <UIViewControllerContextTransitioning> transitionContext;
@property (weak, nonatomic) UIView *toView;

@end

@implementation YXPopVCCubeAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return .7f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    self.toView = toViewController.view;
    
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 0.7;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    [containerView.layer addAnimation:animation forKey:nil];
    [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([self.transitionContext transitionWasCancelled]) {
        [self.transitionContext completeTransition:NO];
    } else {
        [self.transitionContext completeTransition:YES];
    }
}

@end
