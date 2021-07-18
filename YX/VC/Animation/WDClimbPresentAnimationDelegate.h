//
//  WDClimbPresentAnimationDelegate.h
//  YX
//
//  Created by 杨鑫 on 2021/7/19.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WDClimbPresentAnimationDelegate : NSObject<UIViewControllerTransitioningDelegate>

@end

@interface WDClimbPresentAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL isPresent;

@end
