//
//  YXNavigationControllerDelegate.h
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, YXNavigationAnimationStyle) {
    YXNavigationAnimationStyle1,
    YXNavigationAnimationStyle2Cube
};


@interface YXNavigationControllerDelegate : NSObject<UINavigationControllerDelegate>

- (instancetype)initWithNav:(UINavigationController *)navVC;

- (void)setAnimationStyle:(YXNavigationAnimationStyle)style;

@end


@interface YXPushVCAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithControllerDelegate:(YXNavigationControllerDelegate *)controllerDelegate;

@end


@interface YXPopVCAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithControllerDelegate:(YXNavigationControllerDelegate *)controllerDelegate;

@end


@interface YXPercentDrivenPopAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL interacting;

- (void)prepareGestureRecognizer:(UIViewController *)toVC;

- (void)removeGestureRecognizer;

@end
