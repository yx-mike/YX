//
//  YXVCTransitioningDelegate.h
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface YXVCPresentDelegate : NSObject<UIViewControllerTransitioningDelegate>

- (instancetype)initWithRootVC:(UIViewController *)vc;

@end


@interface YXPresentVCAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDelegate:(YXVCPresentDelegate *)presentDelegate;

@end


@interface YXDismissVCAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDelegate:(YXVCPresentDelegate *)presentDelegate;

@end


@interface YXDismissPercentDrivenAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL interacting;

- (instancetype)initWithRootVC:(UIViewController *)vc;

- (void)prepareGestureRecognizer;
- (void)removeGestureRecognizer;

@end
