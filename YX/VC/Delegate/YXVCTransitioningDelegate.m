//
//  YXVCTransitioningDelegate.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXVCTransitioningDelegate.h"
#import "YXPresentVCAnimateion.h"
#import "YXDismissVCAnimateion.h"

@interface YXVCTransitioningDelegate ()

@property (strong, nonatomic) YXPresentVCAnimateion *present;
@property (strong, nonatomic) YXDismissVCAnimateion *dismiss;

@end

@implementation YXVCTransitioningDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        _present = [[YXPresentVCAnimateion alloc] init];
        _dismiss = [[YXDismissVCAnimateion alloc] init];
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

@end
