//
//  CircleView.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    #warning 要了解alpha、opaque、hidden三者的关系和区别
        self.opaque = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor redColor] setFill];
    [[UIBezierPath bezierPathWithOvalInRect:self.bounds] fill];
}

@end
