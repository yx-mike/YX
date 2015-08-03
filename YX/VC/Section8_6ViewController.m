//
//  Section8_6ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section8_6ViewController.h"
//
#import "Macros.h"
#import "Constant.h"

@interface LayerView : UIView

@end

@implementation LayerView

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
    #warning CGLayer缓存常用绘图的内容
    static CGLayerRef sTextLayer = NULL;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (sTextLayer == NULL) {
        CGRect textBounds = CGRectMake(0, 0, 200, 100);
        sTextLayer = CGLayerCreateWithContext(ctx, textBounds.size, NULL);
        
        CGContextRef textCtx = CGLayerGetContext(sTextLayer);
        CGContextSetRGBFillColor(textCtx, 1.0, 0.0, 0.0, 1);
        UIGraphicsPushContext(textCtx);
        UIFont *font = [UIFont systemFontOfSize:13.0];
        [@"Pushing The Limits" drawInRect:textBounds withAttributes:@{NSFontAttributeName:font}];
        UIGraphicsPopContext();
    }
    
    CGContextTranslateCTM(ctx, self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    for (NSUInteger i = 0; i < 10; ++i) {
        CGContextRotateCTM(ctx, (CGFloat)(2 * M_PI / 10));
        CGContextDrawLayerAtPoint(ctx, CGPointZero, sTextLayer);
    }
}

@end

@interface Section8_6ViewController ()

@end

@implementation Section8_6ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"CGLayer";
    //
    [self.view addSubview:[[LayerView alloc] initWithFrame:CGRectMake(0, 0, FullScreenWidth, FullScreenHeight-NavigationHeight)]];
}

@end
