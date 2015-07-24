//
//  Section8_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/19.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section8_2ViewController.h"
//
#import "Macros.h"
#import "Constant.h"

@interface FlowerTransformView : UIView

@end

@implementation FlowerTransformView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AppBackgroundColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGSize size = self.bounds.size;
    CGFloat margin = 10;
    
    [[UIColor redColor] set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(0, -1)
                    radius:1
                startAngle:(CGFloat)-M_PI
                  endAngle:0
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(1, 0)
                    radius:1
                startAngle:(CGFloat)-M_PI_2
                  endAngle:(CGFloat)M_PI_2
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(0, 1)
                    radius:1
                startAngle:0
                  endAngle:(CGFloat)M_PI
                 clockwise:YES];
    [path addArcWithCenter:CGPointMake(-1, 0)
                    radius:1
                startAngle:(CGFloat)M_PI_2
                  endAngle:(CGFloat)-M_PI_2
                 clockwise:YES];
    
    #warning 下绘制小图，再进行缩放、旋转和平移
    CGFloat scale = floorf((MIN(size.height, size.width) - margin) / 4);
    CGAffineTransform transform = CGAffineTransformMake(scale, 0, 0, scale, size.width/2, size.height/2);
    [path applyTransform:transform];
    [path fill];
}

@end

@interface Section8_2ViewController ()

@end

@implementation Section8_2ViewController

- (void)loadView
{
    [super loadView];
    self.title = @"Transform";
    //
    [self.view addSubview:[[FlowerTransformView alloc] initWithFrame:CGRectMake(0, 0, FullkScreenWidth, FullScreenHeight-NavigationHeight)]];
}

@end
