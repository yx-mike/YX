//
//  CALayer+YXAmimation.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "CALayer+YXAmimation.h"

@implementation CALayer (YXAmimation)

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay
{
    #warning 分装显示动画，关闭隐式动画
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self setValue:value forKeyPath:keyPath];
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.duration = duration;
    anim.beginTime = CACurrentMediaTime() + delay;
    #warning CALayer理解模型层和表示层
    anim.fillMode = kCAFillModeBoth;
    anim.fromValue = [[self presentationLayer] valueForKey:keyPath];
    anim.toValue = value;
    [self addAnimation:anim forKey:keyPath];
    [CATransaction commit];
}

@end
