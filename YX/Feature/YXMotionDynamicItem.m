//
//  YXMotionDynamicItem.m
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXMotionDynamicItem.h"


CGPoint YXCPointMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
    CGPoint p;
    p.x = x - w / 2;
    p.y = y - h / 2;
    return p;
}

CGRect YXCRectMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
    CGRect rect;
    rect.origin.x = x - w / 2;
    rect.origin.y = y - h / 2;
    rect.size.width = w;
    rect.size.height = h;
    return rect;
}


@interface YXMotionDynamicItem ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, strong) UIBezierPath *bezierPath;

@end

@implementation YXMotionDynamicItem

- (instancetype)initWithFrame:(CGRect)frame
                         type:(YXMotionDynamicItemType)type
                        image:(UIImage *)image
                   bezierPath:(UIBezierPath *)bezierPath
{
    if (image == nil) {
        frame = CGRectZero;
        bezierPath = nil;
    }
    
    if ([bezierPath isKindOfClass:NSNull.class]) {
        bezierPath = nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        if (image) {
            [self loadViewWithImage:image bounds:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        }
        
        self.bezierPath = bezierPath;
    }
    return self;
}

- (void)loadViewWithImage:(UIImage *)image bounds:(CGRect)bounds {
    if (!image) {
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView = imageView;
    imageView.frame = bounds;
    
    [self addSubview:imageView];
}

#pragma mark - UIDynamicItem

- (UIDynamicItemCollisionBoundsType)collisionBoundsType {
    if (self.bezierPath) {
        return UIDynamicItemCollisionBoundsTypePath;
    }
    
    return UIDynamicItemCollisionBoundsTypeRectangle;
}

/**
 路径必须表示一个逆时针缠绕且无自相交的凸多边形。
 路径中的点 (0,0) 对应于动态项目的中心。

 用于碰撞边界的基于路径的形状。

 当collisionBoundsType属性为UIDynamicItemCollisionBoundsTypePath时，该属性中的对象作为碰撞边界。 如果您的动态项实现了collisionBoundsType 属性，您还必须实现该属性。
 您创建的路径对象必须代表一个逆时针或顺时针缠绕的凸多边形，并且路径不得与自身相交。 路径的(0, 0)点必须位于对应动态项的中心点。 如果中心点与路径的原点不匹配，碰撞行为可能无法按预期工作。
 */
- (UIBezierPath *)collisionBoundingPath {
    return self.bezierPath;
}

@end
