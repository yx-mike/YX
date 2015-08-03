//
//  YXDefaultDynamicBehavior.h
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXDefaultDynamicBehavior : UIDynamicBehavior

- (void)addItem:(id<UIDynamicItem>)item;
- (void)removeItem:(id<UIDynamicItem>)item;

@end
