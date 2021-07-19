//
//  UINavigationController+YXTransitions.h
//  YX
//
//  Created by 杨鑫 on 2021/7/19.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UINavigationController (YXTransitions)

- (void)setTransitionsWDDelegate:(id<UIViewControllerTransitioningDelegate>)transitionsWDDelegate;

- (id<UIViewControllerTransitioningDelegate>)transitionsWDDelegate;

- (void)setNavigationWDDelegate:(id<UINavigationControllerDelegate>)transitionsWDDelegate;

- (id<UINavigationControllerDelegate>)navigationWDDelegate;

@end
