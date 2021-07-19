//
//  UINavigationController+YXTransitions.m
//  YX
//
//  Created by 杨鑫 on 2021/7/19.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <objc/runtime.h>

#import "UINavigationController+YXTransitions.h"


static NSString *kTransitionsWDDelegate = @"kTransitionsWDDelegate";
static NSString *kNavigationWDDelegate = @"kTransitionsWDDelegate";


@implementation UINavigationController (YXTransitions)

- (void)setTransitionsWDDelegate:(id<UIViewControllerTransitioningDelegate>)transitionsWDDelegate {
    objc_setAssociatedObject(self, &kTransitionsWDDelegate, transitionsWDDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UIViewControllerTransitioningDelegate>)transitionsWDDelegate {
    return objc_getAssociatedObject(self, &kTransitionsWDDelegate);
}

- (void)setNavigationWDDelegate:(id<UINavigationControllerDelegate>)navigationWDDelegate {
    objc_setAssociatedObject(self, &kNavigationWDDelegate, navigationWDDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UINavigationControllerDelegate>)navigationWDDelegate {
    return objc_getAssociatedObject(self, &kNavigationWDDelegate);
}

@end
