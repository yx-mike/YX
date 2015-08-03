//
//  YXDragView.m
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXDragView.h"

@interface YXDragView ()

@property (weak, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (weak, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (weak, nonatomic) UIDynamicBehavior *currentBehavior;

@end

@implementation YXDragView

- (instancetype)initWithFrame:(CGRect)frame animator:(UIDynamicAnimator *)animator
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor darkGrayColor];
        self.layer.borderWidth = 2;
        
        _dynamicAnimator = animator;
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        [self addGestureRecognizer:panGestureRecognizer];
        _panGestureRecognizer = panGestureRecognizer;
    }
    return self;
}

#pragma mark - GestureRecognizer

- (void)panHandle:(UIPanGestureRecognizer *)g
{
    if (g.state == UIGestureRecognizerStateEnded || g.state == UIGestureRecognizerStateCancelled) {
        [self stopDrag];
    } else {
        [self dragToPoint:[g locationInView:self.superview]];
    }
}

#pragma mark Drag Code

- (void)dragToPoint:(CGPoint)point
{
    [self.dynamicAnimator removeBehavior:self.currentBehavior];
    
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self snapToPoint:point];
    self.currentBehavior = snapBehavior;
    snapBehavior.damping = .25;
    [self.dynamicAnimator addBehavior:snapBehavior];
}

- (void)stopDrag
{
    [self.dynamicAnimator removeBehavior:self.currentBehavior];
    self.currentBehavior = nil;
}

#pragma mark - <NSCopying>

- (id)copyWithZone:(NSZone *)zone
{
    YXDragView *newDragView = [[[self class] alloc] initWithFrame:CGRectZero animator:self.dynamicAnimator];
    newDragView.bounds = self.bounds;
    newDragView.center = self.center;
    newDragView.transform = self.transform;
    newDragView.alpha = self.alpha;
    return newDragView;
}

@end
