//
//  MultiColorCircleView.m
//  YX
//
//  Created by weidian2015090112 on 15/9/2.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "MultiColorCircleView.h"

@implementation MultiColorCircleView

//创建图层时使用的Class
+(Class)layerClass
{
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置渐变的颜色
        [self drawMultiColor];
        [self drawCircleShape];
    }
    return self;
}

- (void)drawMultiColor
{
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    //渐变方向
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1.0, 1.0);
    
    //渐变颜色数组
    NSMutableArray *mutableColors = [NSMutableArray array];
    for (NSInteger hue = 0; hue <= 360; hue += 10) {
        [mutableColors addObject:(id)[UIColor colorWithHue:1.0*hue/360.0 saturation:1.0 brightness:1.0 alpha:1.0].CGColor];
    }
    layer.colors = mutableColors;
}

- (void)drawCircleShape
{
    // 生产出一个圆的路径
    CGPoint circleCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat circleRadius = self.bounds.size.width/2.0 - 40;
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:circleCenter
                                                              radius:circleRadius
                                                          startAngle:M_PI
                                                            endAngle:-M_PI
                                                           clockwise:NO];
    
    // 生产出一个圆形路径的Layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = circlePath.CGPath;
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth = 2;
    
    // 可以设置出圆的完整性
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1.0;
    
    self.layer.mask = shapeLayer;
}

#pragma mark - Animation

- (void)startAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 5;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = [NSNumber numberWithDouble:0];
    animation.toValue = [NSNumber numberWithDouble:M_PI*2];
    [self.layer addAnimation:animation forKey:@"transform"];
}

- (void)endAnimation
{
    [self.layer removeAllAnimations];
}

@end
