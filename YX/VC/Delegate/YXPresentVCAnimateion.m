//
//  YXPresentVCAnimateion.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXPresentVCAnimateion.h"

@implementation YXPresentVCAnimateion

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
    CGRect frame = toVCView.frame;
    toVCView.frame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, frame.size.height);
    [transitionView addSubview:toVC.view];
    
    UIView *fromVCView = fromVC.view;
    
    [UIView animateWithDuration:.5 animations:^{
        fromVCView.transform = CGAffineTransformMakeScale(.8, .8);
        toVCView.frame = frame;
    } completion:^(BOOL finished){
        fromVCView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:YES];
    }];
}

@end
