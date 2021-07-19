//
//  WDClimbPresentAnimationDelegate.h
//  YX
//
//  Created by 杨鑫 on 2021/7/19.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/// 自定义转场的类
@interface WDClimbPresentAnimationDelegate : NSObject<UIViewControllerTransitioningDelegate>

/// 初始化方法
/// @param vc 加载手势的页面
- (instancetype)initWithRootVC:(UIViewController *)vc;

@end


@interface WDClimbPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDelegate:(WDClimbPresentAnimationDelegate *)presentDelegate;

@end


@interface WDClimbDismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDelegate:(WDClimbPresentAnimationDelegate *)presentDelegate;

@end


@interface WDClimbDismissPercentDrivenAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL interacting;

/// 初始化方法
/// @param vc 加载手势的页面
- (instancetype)initWithRootVC:(UIViewController *)vc;

- (void)prepareGestureRecognizer;
- (void)removeGestureRecognizer;

@end
