//
//  NSLayoutConstraint+YXCommon.h
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (YXCommon)

+ (NSArray *)viewFillSuperView:(UIView *)view;
+ (NSArray *)viewCenterSuperView:(UIView *)view;
+ (NSArray *)view:(UIView *)view width:(CGFloat)width height:(CGFloat)height;

@end
