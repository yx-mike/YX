//
//  NSLayoutConstraint+YXCommon.m
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "NSLayoutConstraint+YXCommon.h"

@implementation NSLayoutConstraint (YXCommon)

+ (NSArray *)viewFillSuperView:(UIView *)view
{
    NSArray *vLCArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view":view}];
    NSArray *hLCArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view":view}];
    
    [view.superview addConstraints:vLCArray];
    [view.superview addConstraints:hLCArray];
    
    return [vLCArray arrayByAddingObjectsFromArray:hLCArray];
}

+ (NSArray *)viewCenterSuperView:(UIView *)view
{
    NSLayoutConstraint *vCenter = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:view.superview attribute:NSLayoutAttributeCenterY
                                                              multiplier:1 constant:0];
    NSLayoutConstraint *hCenter = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:view.superview attribute:NSLayoutAttributeCenterX
                                                              multiplier:1 constant:0];
    
    NSArray *layoutConstraints = @[vCenter, hCenter];
    [view.superview addConstraints:layoutConstraints];
    return layoutConstraints;
}

+ (NSArray *)view:(UIView *)view width:(CGFloat)width height:(CGFloat)height
{
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1 constant:width];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1 constant:height];
    
    NSArray *layoutConstraints = @[widthConstraint, heightConstraint];
    [view addConstraints:layoutConstraints];
    return layoutConstraints;
}

@end
