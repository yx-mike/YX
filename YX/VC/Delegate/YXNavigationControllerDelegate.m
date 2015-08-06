//
//  YXNavigationControllerDelegate.m
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXNavigationControllerDelegate.h"
//
#import "YXPushVCAnimation.h"
#import "YXPopVCAnimation.h"
#import "YXPushVCCubeAnimation.h"
#import "YXPopVCCubeAnimation.h"
#import "YXPercentDrivenPopAnimation.h"

@interface YXNavigationControllerDelegate ()

@end

@implementation YXNavigationControllerDelegate

- (instancetype)initWithNav:(UINavigationController *)navVC
{
    self = [super init];
    if (self) {
        [self setAnimationStyle:YXNavigationAnimationStyle1];
        
        _popPercentDriven = [[YXPercentDrivenPopAnimation alloc] init];
        [_popPercentDriven wireToViewController:navVC];
    }
    return self;
}

- (void)setAnimationStyle:(YXNavigationAnimationStyle)style
{
    switch (style) {
        case YXNavigationAnimationStyle1:{
            self.pushAnimation = [[YXPushVCAnimation alloc] init];
            self.popAnimation = [[YXPopVCAnimation alloc] init];
            break;
        }
            
            
        case YXNavigationAnimationStyle2Cube:{
            self.pushAnimation = [[YXPushVCCubeAnimation alloc] init];
            self.popAnimation = [[YXPopVCCubeAnimation alloc] init];
            break;
        }
            
        default:
            break;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:{
            return self.pushAnimation;
        }
            
        case UINavigationControllerOperationPop:{
            return self.popAnimation;
        }
            
        default:
            break;
    }
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (animationController == self.popAnimation) {
        return self.popPercentDriven.interacting?self.popPercentDriven:nil;
    } else {
        return nil;
    }
}

@end
