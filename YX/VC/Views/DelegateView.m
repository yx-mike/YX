//
//  DelegateView.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "DelegateView.h"

@implementation DelegateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.layer setNeedsDisplay];
    }
    return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    #warning 当使用UIKit绘图时(就是下面的drawInRect方法)，必须使用Push和Pop上下文
    
    UIGraphicsPushContext(ctx);
    
    [[UIColor whiteColor] set];
    UIRectFill(layer.bounds);
    
    [[UIColor blackColor] set];
    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
    pStyle.alignment = NSTextAlignmentCenter;
    pStyle.lineBreakMode = NSLineBreakByWordWrapping;
    UIFont *font = [UIFont systemFontOfSize:18.0];
    [@"Pushing The Limits" drawInRect:[layer bounds] withAttributes:@{NSFontAttributeName: font,
                                                                      NSParagraphStyleAttributeName: pStyle}];
    
    UIGraphicsPopContext();
}

@end
