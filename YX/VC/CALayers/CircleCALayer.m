//
//  CircleCALayer.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "CircleCALayer.h"
#import <UIKit/UIKit.h>

@implementation CircleCALayer

@dynamic radius;

- (id)init {
    self = [super init];
    if (self) {
        [self setNeedsDisplay];
    }
    
    return self;
}

- (id)initWithLayer:(id)layer {
    self = [super initWithLayer:layer];
    [self setRadius:[layer radius]];
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, [[UIColor redColor] CGColor]);
    CGFloat radius = self.radius;
    CGRect rect;
    rect.size = CGSizeMake(radius, radius);
    rect.origin.x = (self.bounds.size.width - radius) / 2;
    rect.origin.y = (self.bounds.size.height - radius) / 2;
    CGContextAddEllipseInRect(ctx, rect);
    CGContextFillPath(ctx);
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"radius"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (id < CAAction >)actionForKey:(NSString *)key {
    if ([self presentationLayer] != nil) {
        if ([key isEqualToString:@"radius"]) {
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"radius"];
            anim.fromValue = [[self presentationLayer] valueForKey:@"radius"];
            return anim;
        }
    }
    
    return [super actionForKey:key];
}

@end
