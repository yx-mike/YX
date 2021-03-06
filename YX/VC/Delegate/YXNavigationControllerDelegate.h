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

@class YXPercentDrivenPopAnimation;

@interface YXNavigationControllerDelegate : NSObject<UINavigationControllerDelegate>

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> pushAnimation;
@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> popAnimation;
@property (strong, nonatomic) YXPercentDrivenPopAnimation *popPercentDriven;

- (instancetype)initWithNav:(UINavigationController *)navVC;
- (void)setAnimationStyle:(YXNavigationAnimationStyle)style;

@end
