//
//  YXVCTransitioningDelegate.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXVCPresentDelegate.h"
#import "YXPresentVCAnimation.h"
#import "YXDismissVCAnimation.h"
#import "YXDismissPercentDrivenAnimation.h"

@interface YXVCPresentDelegate ()

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> present;
@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> dismiss;

@end

@implementation YXVCPresentDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _present = [[YXPresentVCAnimation alloc] init];
        _dismiss = [[YXDismissVCAnimation alloc] init];
    }
    return self;
}

#pragma mark <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self.present;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismiss;
}

-(id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.dismissPercentDriven.interacting?self.dismissPercentDriven:nil;
}

@end
