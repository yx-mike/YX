//
//  Section8_3ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/19.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section8_3ViewController.h"
//
#import "Macros.h"
#import "Constant.h"

@interface GraphView : UIView

@property (nonatomic, readonly, strong) NSMutableArray *values;

@end

@implementation GraphView
{
    dispatch_source_t _timer;
}

const CGFloat kXScale = 5.0;
const CGFloat kYScale = 100.0;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AppBackgroundColor;
        
        [self setContentMode:UIViewContentModeRight];
        _values = [NSMutableArray array];
        
        #warning 定时器的一种实现
        __weak id weakSelf = self;
        double delayInSeconds = 0.02;
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer( _timer, dispatch_walltime(NULL, 0), (unsigned)(delayInSeconds * NSEC_PER_SEC), 0);
        dispatch_source_set_event_handler(_timer, ^{
            [weakSelf updateValues];
        });
        dispatch_resume(_timer);
    }
    return self;
}

- (void)dealloc {
    dispatch_source_cancel(_timer);
}

- (void)updateValues {
    double nextValue = sin(CFAbsoluteTimeGetCurrent()) + ((double)rand()/(double)RAND_MAX);
    [self.values addObject:[NSNumber numberWithDouble:nextValue]];
    CGSize size = self.bounds.size;
    CGFloat maxDimension = MAX(size.height, size.width);
    NSUInteger maxValues = (NSUInteger)floorl(maxDimension / kXScale);
    
    if ([self.values count] > maxValues) {
        [self.values removeObjectsInRange:NSMakeRange(0, [self.values count] - maxValues)];
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if ([self.values count] == 0) {
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [[UIColor redColor] CGColor]);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, 5);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat yOffset = self.bounds.size.height / 2;
    CGAffineTransform transform = CGAffineTransformMake(kXScale, 0, 0, kYScale, 0, yOffset);
    
    CGFloat y = [[self.values objectAtIndex:0] floatValue];
    CGPathMoveToPoint(path, &transform, 0, y);
    
    for (NSUInteger x = 1; x < [self.values count]; ++x) {
        y = [[self.values objectAtIndex:x] floatValue];
        CGPathAddLineToPoint(path, &transform, x, y);
    }
    
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    CGContextStrokePath(ctx);
}

@end

@interface Section8_3ViewController ()

@end

@implementation Section8_3ViewController

- (void)loadView
{
    [super loadView];
    self.title = @"Graph";
    //
    [self.view addSubview:[[GraphView alloc] initWithFrame:CGRectMake(0, 0, FullkScreenWidth, FullScreenHeight-NavigationHeight)]];
}

@end
