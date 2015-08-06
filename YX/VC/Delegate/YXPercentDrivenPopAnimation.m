//
//  YXPercentDrivenPopAnimation.m
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXPercentDrivenPopAnimation.h"

@interface YXPercentDrivenPopAnimation ()

@property (nonatomic, strong) UINavigationController *navVC;

@end

@implementation YXPercentDrivenPopAnimation

- (void)wireToViewController:(UINavigationController *)navVC
{
    self.navVC = navVC;
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [navVC.view addGestureRecognizer:panG];
}

- (void)panHandle:(UIPanGestureRecognizer *)g
{
    UIGestureRecognizerState state = g.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        CGPoint movePoint = [g translationInView:self.navVC.view];
        if (self.navVC.viewControllers.count > 1 && movePoint.x > 0) {
            [self.navVC popViewControllerAnimated:YES];
        }
    } else if (state == UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [g translationInView:self.navVC.view];
        if (movePoint.x <= 0) {
            [self updateInteractiveTransition:0];
        } else {
            [self updateInteractiveTransition:movePoint.x/self.navVC.view.frame.size.width];
        }
    } else if (state == UIGestureRecognizerStateEnded) {
        self.interacting = NO;
        CGPoint movePoint = [g translationInView:self.navVC.view];
        if (movePoint.x <= 0) {
            [self cancelInteractiveTransition];
        } else {
            if (movePoint.x/self.navVC.view.frame.size.width > .4) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
    } else if (state == UIGestureRecognizerStateCancelled) {
        self.interacting = NO;
        [self cancelInteractiveTransition];
    }
}

@end
