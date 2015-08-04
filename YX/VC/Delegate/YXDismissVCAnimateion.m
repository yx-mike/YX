//
//  YXdissmissVCAnimateion.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXDismissVCAnimateion.h"

@implementation YXDismissVCAnimateion

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = fromVC.view.superview;
    UIView *toVCView = toVC.view;
    UIView *fromVCView = fromVC.view;
    
    [fromVCView removeFromSuperview];
    [transitionView addSubview:toVCView];
    [transitionView addSubview:fromVCView];
    
    toVCView.transform = CGAffineTransformMakeScale(.8, .8);
    
    CGRect frame = fromVCView.frame;
    frame.origin.y += frame.size.height;
    
    [UIView animateWithDuration:.5 animations:^{
        fromVCView.frame = frame;
        toVCView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        [transitionContext completeTransition:YES];
    }];
}

@end
