//
//  Section19_iOS7_6ViewController.m
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_6ViewController.h"

#import "YXMotionDynamicMaker.h"
#import "YXMotionDynamicItem.h"


@interface Section19_iOS7_6ViewController ()

@property (nonatomic, strong) YXMotionDynamicMaker *motionDynamicMaker;

@end

@implementation Section19_iOS7_6ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [YXMotionDynamicItem prepareImageSizeMap:[self prepareSizeMap] imageBezierMap:[self prepareBezierMao]];
    
    self.motionDynamicMaker = [[YXMotionDynamicMaker alloc] initWithView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

#pragma mark - Test Data

- (NSDictionary *)prepareSizeMap {
    return @{
        @"yx_dynamic_1": [NSValue valueWithCGSize:CGSizeMake(18, 18)],
        @"yx_dynamic_2": [NSValue valueWithCGSize:CGSizeMake(18, 18)],
        @"yx_dynamic_3": [NSValue valueWithCGSize:CGSizeMake(18, 18)],
        @"yx_dynamic_4": [NSValue valueWithCGSize:CGSizeMake(18, 18)],
        @"yx_dynamic_5": [NSValue valueWithCGSize:CGSizeMake(18, 18)],
        @"yx_dynamic_6": [NSValue valueWithCGSize:CGSizeMake(18, 18)],
        @"yx_dynamic_7": [NSValue valueWithCGSize:CGSizeMake(15, 15)],
        @"yx_dynamic_8": [NSValue valueWithCGSize:CGSizeMake(76, 26)],
        @"yx_dynamic_9": [NSValue valueWithCGSize:CGSizeMake(30, 54)],
        @"yx_dynamic_10": [NSValue valueWithCGSize:CGSizeMake(57, 57)],
        @"yx_dynamic_11": [NSValue valueWithCGSize:CGSizeMake(15, 10)],
        @"yx_dynamic_12": [NSValue valueWithCGSize:CGSizeMake(51, 18)],
        @"yx_dynamic_13": [NSValue valueWithCGSize:CGSizeMake(48, 48)],
        @"yx_dynamic_14": [NSValue valueWithCGSize:CGSizeMake(80, 80)],
        @"yx_dynamic_15": [NSValue valueWithCGSize:CGSizeMake(37, 23)],
        @"yx_dynamic_16": [NSValue valueWithCGSize:CGSizeMake(51, 63)],
    };
}

- (NSDictionary *)prepareBezierMao {
    UIBezierPath *bezierPath1 = [[UIBezierPath alloc] init];
    [bezierPath1 moveToPoint:CGPointMake(3, 4)];
    [bezierPath1 addLineToPoint:CGPointMake(9, 4)];
    [bezierPath1 addLineToPoint:CGPointMake(9, 1)];
    [bezierPath1 addLineToPoint:CGPointMake(12, 0)];
    [bezierPath1 addLineToPoint:CGPointMake(14, 0)];
    [bezierPath1 addLineToPoint:CGPointMake(14, 2)];
    [bezierPath1 addLineToPoint:CGPointMake(12, 4)];
    [bezierPath1 addLineToPoint:CGPointMake(15, 4)];
    [bezierPath1 addLineToPoint:CGPointMake(15, 8)];
    [bezierPath1 addLineToPoint:CGPointMake(14, 8)];
    [bezierPath1 addLineToPoint:CGPointMake(14, 13)];
    [bezierPath1 addLineToPoint:CGPointMake(13, 13)];
    [bezierPath1 addLineToPoint:CGPointMake(13, 18)];
    [bezierPath1 addLineToPoint:CGPointMake(5, 18)];
    [bezierPath1 addLineToPoint:CGPointMake(5, 13)];
    [bezierPath1 addLineToPoint:CGPointMake(4, 13)];
    [bezierPath1 addLineToPoint:CGPointMake(4, 8)];
    [bezierPath1 addLineToPoint:CGPointMake(3, 8)];
    [bezierPath1 closePath];
    
    UIBezierPath *bezierPath2 = [[UIBezierPath alloc] init];
    [bezierPath2 moveToPoint:CGPointMake(4, 10)];
    [bezierPath2 addLineToPoint:CGPointMake(5, 9)];
    [bezierPath2 addLineToPoint:CGPointMake(5, 6)];
    [bezierPath2 addLineToPoint:CGPointMake(6, 6)];
    [bezierPath2 addLineToPoint:CGPointMake(6, 1)];
    [bezierPath2 addLineToPoint:CGPointMake(7, 0)];
    [bezierPath2 addLineToPoint:CGPointMake(11, 0)];
    [bezierPath2 addLineToPoint:CGPointMake(12, 2)];
    [bezierPath2 addLineToPoint:CGPointMake(12, 6)];
    [bezierPath2 addLineToPoint:CGPointMake(13, 6)];
    [bezierPath2 addLineToPoint:CGPointMake(13, 9)];
    [bezierPath2 addLineToPoint:CGPointMake(14, 10)];
    [bezierPath2 addLineToPoint:CGPointMake(19, 17)];
    [bezierPath2 addLineToPoint:CGPointMake(13, 18)];
    [bezierPath2 addLineToPoint:CGPointMake(5, 18)];
    [bezierPath2 addLineToPoint:CGPointMake(4, 17)];
    [bezierPath2 closePath];
    
    UIBezierPath *bezierPath3 = [[UIBezierPath alloc] init];
    [bezierPath3 moveToPoint:CGPointMake(2, 8)];
    [bezierPath3 addLineToPoint:CGPointMake(4, 6)];
    [bezierPath3 addLineToPoint:CGPointMake(4, 4)];
    [bezierPath3 addLineToPoint:CGPointMake(7, 2)];
    [bezierPath3 addLineToPoint:CGPointMake(7, 0)];
    [bezierPath3 addLineToPoint:CGPointMake(11, 0)];
    [bezierPath3 addLineToPoint:CGPointMake(11, 2)];
    [bezierPath3 addLineToPoint:CGPointMake(14, 4)];
    [bezierPath3 addLineToPoint:CGPointMake(14, 6)];
    [bezierPath3 addLineToPoint:CGPointMake(16, 8)];
    [bezierPath3 addLineToPoint:CGPointMake(16, 15)];
    [bezierPath3 addLineToPoint:CGPointMake(14, 18)];
    [bezierPath3 addLineToPoint:CGPointMake(5, 18)];
    [bezierPath3 addLineToPoint:CGPointMake(2, 16)];
    [bezierPath3 closePath];
    
    UIBezierPath *bezierPath4 = [[UIBezierPath alloc] init];
    [bezierPath4 moveToPoint:CGPointMake(1, 6)];
    [bezierPath4 addLineToPoint:CGPointMake(2, 5)];
    [bezierPath4 addLineToPoint:CGPointMake(4, 5)];
    [bezierPath4 addLineToPoint:CGPointMake(8, 1)];
    [bezierPath4 addLineToPoint:CGPointMake(10, 1)];
    [bezierPath4 addLineToPoint:CGPointMake(13, 4)];
    [bezierPath4 addLineToPoint:CGPointMake(17, 6)];
    [bezierPath4 addLineToPoint:CGPointMake(17, 9)];
    [bezierPath4 addLineToPoint:CGPointMake(15, 12)];
    [bezierPath4 addLineToPoint:CGPointMake(15, 15)];
    [bezierPath4 addLineToPoint:CGPointMake(14, 17)];
    [bezierPath4 addLineToPoint:CGPointMake(11, 17)];
    [bezierPath4 addLineToPoint:CGPointMake(10, 16)];
    [bezierPath4 addLineToPoint:CGPointMake(8, 16)];
    [bezierPath4 addLineToPoint:CGPointMake(7, 17)];
    [bezierPath4 addLineToPoint:CGPointMake(5, 17)];
    [bezierPath4 addLineToPoint:CGPointMake(3, 16)];
    [bezierPath4 addLineToPoint:CGPointMake(3, 12)];
    [bezierPath4 addLineToPoint:CGPointMake(1, 9)];
    [bezierPath4 closePath];
    
    UIBezierPath *bezierPath5 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(9, 9) radius:9
                                                           startAngle:0 endAngle:M_PI * 2
                                                            clockwise:YES];
    
    UIBezierPath *bezierPath6 = [[UIBezierPath alloc] init];
    [bezierPath6 moveToPoint:CGPointMake(1, 3)];
    [bezierPath6 addLineToPoint:CGPointMake(2, 2)];
    [bezierPath6 addLineToPoint:CGPointMake(4, 2)];
    [bezierPath6 addLineToPoint:CGPointMake(4, 1)];
    [bezierPath6 addLineToPoint:CGPointMake(5, 0)];
    [bezierPath6 addLineToPoint:CGPointMake(9, 0)];
    [bezierPath6 addLineToPoint:CGPointMake(10, 1)];
    [bezierPath6 addLineToPoint:CGPointMake(11, 0)];
    [bezierPath6 addLineToPoint:CGPointMake(13, 0)];
    [bezierPath6 addLineToPoint:CGPointMake(17, 3)];
    [bezierPath6 addLineToPoint:CGPointMake(17, 7)];
    [bezierPath6 addLineToPoint:CGPointMake(18, 8)];
    [bezierPath6 addLineToPoint:CGPointMake(18, 12)];
    [bezierPath6 addLineToPoint:CGPointMake(16, 14)];
    [bezierPath6 addLineToPoint:CGPointMake(15, 14)];
    [bezierPath6 addLineToPoint:CGPointMake(15, 16)];
    [bezierPath6 addLineToPoint:CGPointMake(13, 18)];
    [bezierPath6 addLineToPoint:CGPointMake(5, 18)];
    [bezierPath6 addLineToPoint:CGPointMake(2, 16)];
    [bezierPath6 addLineToPoint:CGPointMake(2, 7)];
    [bezierPath6 addLineToPoint:CGPointMake(1, 6)];
    [bezierPath6 closePath];
    
    UIBezierPath *bezierPath7 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(7.5, 7.5) radius:7.5
                                                           startAngle:0 endAngle:M_PI * 2
                                                            clockwise:YES];
    
    id bezierPath8 = [[NSNull alloc] init];
    
    UIBezierPath *bezierPath9 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 30, 54)
                                                      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                            cornerRadii:CGSizeMake(5, 5)];
    
    UIBezierPath *bezierPath10 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 57, 57) cornerRadius:3];
    
    id bezierPath11 = [[NSNull alloc] init];
    
    id bezierPath12 = [[NSNull alloc] init];
    
    UIBezierPath *bezierPath13 = [[UIBezierPath alloc] init];
    [bezierPath13 moveToPoint:CGPointMake(0, 39)];
    [bezierPath13 addLineToPoint:CGPointMake(12, 13)];
    [bezierPath13 addLineToPoint:CGPointMake(38, 0)];
    [bezierPath13 addLineToPoint:CGPointMake(44, 0)];
    [bezierPath13 addLineToPoint:CGPointMake(76, 31)];
    [bezierPath13 addLineToPoint:CGPointMake(76, 64)];
    [bezierPath13 addLineToPoint:CGPointMake(64, 64)];
    [bezierPath13 addLineToPoint:CGPointMake(64, 76)];
    [bezierPath13 addLineToPoint:CGPointMake(30, 76)];
    [bezierPath13 addLineToPoint:CGPointMake(0, 45)];
    [bezierPath13 closePath];
    
    UIBezierPath *bezierPath14 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:40
                                                            startAngle:0 endAngle:M_PI * 2
                                                             clockwise:YES];
    
    UIBezierPath *bezierPath15 = [[UIBezierPath alloc] init];
    [bezierPath15 moveToPoint:CGPointMake(0, 20)];
    [bezierPath15 addLineToPoint:CGPointMake(5, 0)];
    [bezierPath15 addLineToPoint:CGPointMake(37, 0)];
    [bezierPath15 addLineToPoint:CGPointMake(37, 3)];
    [bezierPath15 addLineToPoint:CGPointMake(32, 23)];
    [bezierPath15 addLineToPoint:CGPointMake(0, 23)];
    [bezierPath15 closePath];
    
    UIBezierPath *bezierPath16 = [[UIBezierPath alloc] init];
    [bezierPath16 moveToPoint:CGPointMake(0, 31)];
    [bezierPath16 addLineToPoint:CGPointMake(30, 0)];
    [bezierPath15 addLineToPoint:CGPointMake(51, 0)];
    [bezierPath15 addLineToPoint:CGPointMake(32, 20)];
    [bezierPath15 addLineToPoint:CGPointMake(32, 29)];
    [bezierPath15 addLineToPoint:CGPointMake(51, 29)];
    [bezierPath15 addLineToPoint:CGPointMake(35, 46)];
    [bezierPath15 addLineToPoint:CGPointMake(51, 64)];
    [bezierPath15 addLineToPoint:CGPointMake(30, 64)];
    [bezierPath15 addLineToPoint:CGPointMake(0, 32)];
    [bezierPath16 closePath];
    
    return @{
        @"yx_dynamic_1": bezierPath1,
        @"yx_dynamic_2": bezierPath2,
        @"yx_dynamic_3": bezierPath3,
        @"yx_dynamic_4": bezierPath4,
        @"yx_dynamic_5": bezierPath5,
        @"yx_dynamic_6": bezierPath6,
        @"yx_dynamic_7": bezierPath7,
        @"yx_dynamic_8": bezierPath8,
        @"yx_dynamic_9": bezierPath9,
        @"yx_dynamic_10": bezierPath10,
        @"yx_dynamic_11": bezierPath11,
        @"yx_dynamic_12": bezierPath12,
        @"yx_dynamic_13": bezierPath13,
        @"yx_dynamic_14": bezierPath14,
        @"yx_dynamic_15": bezierPath15,
        @"yx_dynamic_16": bezierPath16,
    };
}

@end
