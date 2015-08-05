//
//  YXPopVCAnimation.m
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXPopVCAnimation.h"

@implementation YXPopVCAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return .5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = [transitionContext containerView];
    UIView *toVCView = toVC.view;
    UIView *fromVCView = fromVC.view;
    
    [transitionView insertSubview:toVCView belowSubview:fromVCView];
    
    toVCView.transform = CGAffineTransformMakeScale(.8, .8);
    
    CGRect frame = fromVCView.frame;
    frame.origin.x += frame.size.width;
    
    [UIView animateWithDuration:.5 animations:^{
        fromVCView.frame = frame;
        toVCView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        if ([transitionContext transitionWasCancelled]) {
            [toVCView removeFromSuperview];
            [transitionContext completeTransition:NO];
        } else {
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
