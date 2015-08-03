//
//  Section8_1ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/19.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section8_1ViewController.h"
//
#import "Macros.h"
#import "Constant.h"
#import "FunCMacros.h"

@interface FlowerView : UIView

@end

@implementation FlowerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AppBackgroundColor;
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGSize size = self.bounds.size;
    CGFloat margin = 10;
    CGFloat radius = rintf(MIN(size.height - margin,
                               size.width - margin) / 4);
    
    CGFloat xOffset, yOffset;
    CGFloat offset = rintf((size.height - size.width) / 2);
    if (offset > 0) {
        xOffset = (CGFloat)rint(margin / 2);
        yOffset = offset;
    } else {
        xOffset = -offset;
        yOffset = rintf(margin / 2);
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(radius * 2 + xOffset,
                                       radius + yOffset)
                    radius:radius
                startAngle:(CGFloat)-M_PI
                  endAngle:0
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 3 + xOffset,
                                       radius * 2 + yOffset)
                    radius:radius
                startAngle:(CGFloat)-M_PI_2
                  endAngle:(CGFloat)M_PI_2
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius * 2 + xOffset,
                                       radius * 3 + yOffset)
                    radius:radius
                startAngle:0
                  endAngle:(CGFloat)M_PI
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(radius + xOffset,
                                       radius * 2 + yOffset)
                    radius:radius
                startAngle:(CGFloat)M_PI_2
                  endAngle:(CGFloat)-M_PI_2
                 clockwise:YES];
    [path closePath];
    
    [[UIColor redColor] setFill];
    [path fill];
}

@end

@interface Section8_1ViewController ()

@end

@implementation Section8_1ViewController

- (void)loadView
{
    [super loadView];
    self.title = @"Paths";
    //
    [self.view addSubview:[[FlowerView alloc] initWithFrame:CGRectMake(0, 0, FullScreenWidth, FullScreenHeight-NavigationHeight)]];
}

@end
