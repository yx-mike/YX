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
#import "YXPercentDrivenPopAnimation.h"

@interface YXNavigationControllerDelegate ()

@property (weak, nonatomic) UINavigationController *navVC;

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> pushAnimation;
@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> popAnimation;
@property (strong, nonatomic) YXPercentDrivenPopAnimation *popPercentDriven;

@end

@implementation YXNavigationControllerDelegate

- (instancetype)initWithNav:(UINavigationController *)navVC
{
    self = [super init];
    if (self) {
        _navVC = navVC;
        _pushAnimation = [[YXPushVCAnimation alloc] init];
        _popAnimation = [[YXPopVCAnimation alloc] init];
        
        _popPercentDriven = [[YXPercentDrivenPopAnimation alloc] init];
        [_popPercentDriven wireToViewController:navVC];
    }
    return self;
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
        return self.popPercentDriven;
    } else {
        return nil;
    }
}

@end
