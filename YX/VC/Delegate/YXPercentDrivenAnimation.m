//
//  YXPercentDrivenAnimation.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXPercentDrivenAnimation.h"

@interface YXPercentDrivenAnimation ()

@property (nonatomic, strong) UIViewController *presentedVC;

@end

@implementation YXPercentDrivenAnimation

- (void)wireToViewController:(UIViewController *)viewController
{
    self.presentedVC = viewController;
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [viewController.view addGestureRecognizer:panG];
}

- (void)panHandle:(UIPanGestureRecognizer *)g
{
    UIGestureRecognizerState state = g.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
    } else if (state == UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [g translationInView:self.presentedVC.view];
        if (movePoint.y <= 0) {
            [self updateInteractiveTransition:0];
        } else {
            [self updateInteractiveTransition:movePoint.y/self.presentedVC.view.frame.size.height];
        }
    } else if (state == UIGestureRecognizerStateEnded) {
        self.interacting = NO;
        CGPoint movePoint = [g translationInView:self.presentedVC.view];
        if (movePoint.y <= 0) {
            [self cancelInteractiveTransition];
        } else {
            if (movePoint.y/self.presentedVC.view.frame.size.height > .4) {
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
