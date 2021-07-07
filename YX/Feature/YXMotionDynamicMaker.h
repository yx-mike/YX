//
//  YXMotionDynamicMaker.h
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXMotionDynamicMaker : NSObject

- (instancetype)initWithView:(UIView *)view;

- (void)loadItems;

- (void)startMotion;
- (void)stopMotion;

- (void)addItem:(id<UIDynamicItem>)item;

@end

NS_ASSUME_NONNULL_END
