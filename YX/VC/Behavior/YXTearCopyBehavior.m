//
//  YXTearCopyBehavior.m
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXTearCopyBehavior.h"
//
#import "YXDragView.h"

BOOL PointsAreWithinDistance(CGPoint p1, CGPoint p2, CGFloat distance) {
    CGFloat dx = p1.x - p2.x;
    CGFloat dy = p1.y - p2.y;
    CGFloat currentDistance = hypotf(dx, dy);
    return currentDistance<distance;
}

@interface YXTearCopyBehavior ()

@property (weak, nonatomic) YXDragView *dragView;
@property (nonatomic) BOOL active;

@end

@implementation YXTearCopyBehavior

- (instancetype) initWithDragView:(YXDragView *)dragView handle:(TearOffHandler)handle
{
    self = [super init];
    if (self) {
        _dragView = dragView;
        
        [self addChildBehavior:[[UISnapBehavior alloc] initWithItem:dragView snapToPoint:CGPointMake(40, 40)]];
        
        YXTearCopyBehavior *weakOne = self;
        self.action = ^{
            YXTearCopyBehavior *stongOne = weakOne;
            
            if (!PointsAreWithinDistance(dragView.center, CGPointMake(40, 40), 100)) {
                if (stongOne.active) {
                    YXDragView *newDragView = [dragView copy];
                    [dragView.superview addSubview:newDragView];
                    
                    YXTearCopyBehavior *newTearOff = [[[stongOne class] alloc] initWithDragView:newDragView handle:handle];
                    newTearOff.active = NO;
                    [stongOne.dynamicAnimator addBehavior:newTearOff];
                    
                    handle(stongOne.dragView);
                    
                    [stongOne.dynamicAnimator removeBehavior:stongOne];
                }
            } else {
                stongOne.active = YES;
            }
        };
    }
    return self;
}

@end
