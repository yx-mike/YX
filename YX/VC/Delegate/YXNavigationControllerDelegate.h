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

@property (nonatomic, assign) YXNavigationAnimationStyle animationStyle;

- (instancetype)initWithNav:(UINavigationController *)navVC;

@end


#pragma mark - Push

@interface YXPushVCAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithControllerDelegate:(YXNavigationControllerDelegate *)controllerDelegate;

@end

@interface YXPopVCAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithControllerDelegate:(YXNavigationControllerDelegate *)controllerDelegate;

@end


#pragma mark - Cube

@interface YXPushVCCubeAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end

@interface YXPopVCCubeAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end


#pragma mark - 手势

@interface YXPercentDrivenPopAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, readonly) BOOL interacting;

- (void)prepareGestureRecognizer:(UIViewController *)toVC;

- (void)removeGestureRecognizer;

@end
