//
//  YXDefaultDynamicBehavior.m
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXDefaultDynamicBehavior.h"

@implementation YXDefaultDynamicBehavior

- (instancetype)init {
    self = [super init];
    if (self) {
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
        collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        [self addChildBehavior:collisionBehavior];
        
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
        [self addChildBehavior:gravityBehavior];
    }
    return self;
}

- (void)addItem:(id<UIDynamicItem>)item {
    for (id behavior in self.childBehaviors) {
        [behavior addItem:item];
    }
}

- (void)removeItem:(id<UIDynamicItem>)item {
    for (id behavior in self.childBehaviors) {
        [behavior removeItem:item];
    }
}

@end
