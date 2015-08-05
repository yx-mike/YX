//
//  YXVCTransitioningDelegate.h
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YXDismissPercentDrivenAnimation;

@interface YXVCPresentDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) YXDismissPercentDrivenAnimation *dismissPercentDriven;

@end
