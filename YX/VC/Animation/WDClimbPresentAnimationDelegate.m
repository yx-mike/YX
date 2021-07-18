//
//  WDClimbPresentAnimationDelegate.m
//  YX
//
//  Created by 杨鑫 on 2021/7/19.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "WDClimbPresentAnimationDelegate.h"


@implementation WDClimbPresentAnimationDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    WDClimbPresentAnimation *leftPresentAnimation = [[WDClimbPresentAnimation alloc] init];
    leftPresentAnimation.isPresent = YES;
    return leftPresentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    WDClimbPresentAnimation *leftPresentAnimation = [[WDClimbPresentAnimation alloc] init];
    return leftPresentAnimation;
}

@end


@implementation WDClimbPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    BOOL isPresent = self.isPresent;
    
    CGRect endRect4To = toView.frame;
    
    CGRect startRect4To = toView.frame;
    
    CGRect endRect4ToFrom = fromView.frame;
    
    if (isPresent) {
        startRect4To.origin.y -= startRect4To.size.height;
        
        endRect4ToFrom.origin.y += endRect4ToFrom.size.height;
    } else {
        startRect4To.origin.y = 0;
        startRect4To.origin.y += startRect4To.size.height;
        
        endRect4To.origin.y = 0;
        
        endRect4ToFrom.origin.y -= endRect4ToFrom.size.height;
    }
    
    toView.frame = startRect4To;
    
    [[transitionContext containerView] addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
                        options:isPresent ? UIViewAnimationOptionCurveEaseIn : UIViewAnimationOptionCurveEaseOut
                     animations:^{
        toView.frame = endRect4To;
        fromView.frame = endRect4ToFrom;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
