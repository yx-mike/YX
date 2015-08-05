//
//  YXPushVCAnimation.m
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXPushVCAnimation.h"

@implementation YXPushVCAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return .5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = [transitionContext containerView];
    UIView *fromVCView = fromVC.view;
    UIView *toVCView = toVC.view;
    CGRect frame = toVCView.frame;
    toVCView.frame = CGRectMake(frame.origin.x+frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    [transitionView addSubview:toVCView];
    
    
    
    [UIView animateWithDuration:.5 animations:^{
        fromVCView.transform = CGAffineTransformMakeScale(.8, .8);
        toVCView.frame = frame;
    } completion:^(BOOL finished){
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        } else {
            fromVCView.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:YES];
        }
    }];
}

@end
