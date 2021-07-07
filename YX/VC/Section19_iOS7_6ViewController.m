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

@property (nonatomic, weak) UIView *dynamicView;

@property (nonatomic, strong) YXMotionDynamicMaker *motionDynamicMaker;

@end

@implementation Section19_iOS7_6ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect bounds = self.view.bounds;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    rect.size.width = bounds.size.width - 0;
    rect.size.height = bounds.size.height - 34;
    UIView *dynamicView = [[UIView alloc] initWithFrame:rect];
    dynamicView.backgroundColor = [UIColor lightGrayColor];
    self.dynamicView = dynamicView;
    [self.view addSubview:dynamicView];
    
    self.motionDynamicMaker = [[YXMotionDynamicMaker alloc] initWithView:self.dynamicView];
    
    NSDictionary *sizeMap = [self prepareSizeMap];
    NSDictionary *bezierMap = [self prepareBezierMap];
    
    [sizeMap enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSValue *obj, BOOL *stop) {
        CGSize size = obj.CGSizeValue;
        CGRect rect = CGRectMake(20 + random() % 150, 20, size.width, size.height);
        
        UIImage *image = [UIImage imageNamed:key];
        
        UIBezierPath *bezierPath = bezierMap[key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            YXMotionDynamicItem *itemView;
            itemView = [[YXMotionDynamicItem alloc] initWithFrame:rect
                                                             type:YXMotionDynamicItemTypeDefault
                                                            image:image
                                                       bezierPath:bezierPath];
            
            [self.dynamicView addSubview:itemView];
            [self.motionDynamicMaker addItem:itemView];
        });
    }];
}

#pragma mark - Test Data

- (NSDictionary *)prepareSizeMap {
    return @{
        @"yx_dynamic_1": [NSValue valueWithCGSize:CGSizeMake(12, 18)],
        @"yx_dynamic_2": [NSValue valueWithCGSize:CGSizeMake(10, 18)],
        @"yx_dynamic_3": [NSValue valueWithCGSize:CGSizeMake(13, 18)],
        @"yx_dynamic_4": [NSValue valueWithCGSize:CGSizeMake(16, 16)],
        @"yx_dynamic_5": [NSValue valueWithCGSize:CGSizeMake(16.5, 16.5)],
        @"yx_dynamic_6": [NSValue valueWithCGSize:CGSizeMake(17, 18)],
        @"yx_dynamic_7": [NSValue valueWithCGSize:CGSizeMake(15, 15)],
        @"yx_dynamic_8": [NSValue valueWithCGSize:CGSizeMake(75, 25)],
        @"yx_dynamic_9": [NSValue valueWithCGSize:CGSizeMake(30, 54)],
        @"yx_dynamic_10": [NSValue valueWithCGSize:CGSizeMake(57, 57)],
        @"yx_dynamic_11": [NSValue valueWithCGSize:CGSizeMake(15, 10)],
        @"yx_dynamic_12": [NSValue valueWithCGSize:CGSizeMake(51, 18)],
        @"yx_dynamic_13": [NSValue valueWithCGSize:CGSizeMake(76, 76)],
        @"yx_dynamic_14": [NSValue valueWithCGSize:CGSizeMake(80, 80)],
        @"yx_dynamic_16": [NSValue valueWithCGSize:CGSizeMake(51, 63)],
    };
}

- (NSDictionary *)prepareBezierMap {
    UIBezierPath *bezierPath1 = [[UIBezierPath alloc] init];
    [bezierPath1 moveToPoint:YXCPointMake(0, 4, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(9, 0, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(10, 0, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(12, 4, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(12, 8, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(10, 18, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(2, 18, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(0, 8, 12, 18)];
    [bezierPath1 closePath];
    
    UIBezierPath *bezierPath2 = [[UIBezierPath alloc] init];
    [bezierPath2 moveToPoint:YXCPointMake(0, 10, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(2, 2, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(3, 0, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(7, 0, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(8, 2, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(10, 10, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(10, 16, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(8, 18, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(2, 18, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(0, 16, 10, 18)];
    [bezierPath2 closePath];
    
    UIBezierPath *bezierPath3 = [[UIBezierPath alloc] init];
    [bezierPath3 moveToPoint:YXCPointMake(0, 8, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(2, 3, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(5, 0, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(8, 0, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(11, 3, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(13, 8, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(13, 15, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(11, 18, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(2, 18, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(0, 16, 13, 18)];
    [bezierPath3 closePath];
    
    UIBezierPath *bezierPath4 = [[UIBezierPath alloc] init];
    [bezierPath4 moveToPoint:YXCPointMake(0, 5, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(7, 0, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(9, 0, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(16, 5, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(16, 8, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(14, 14, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(13, 16, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(4, 16, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(2, 14, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(0, 8, 16, 16)];
    [bezierPath4 closePath];
    
    UIBezierPath *bezierPath5 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                               radius:11
                                                           startAngle:0
                                                             endAngle:M_PI * 2
                                                            clockwise:YES];
    
    UIBezierPath *bezierPath6 = [[UIBezierPath alloc] init];
    [bezierPath6 moveToPoint:YXCPointMake(0, 3, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(1, 2, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(4, 0, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(12, 0, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(16, 3, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(17, 8, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(17, 12, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(12, 18, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(4, 18, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(1, 16, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(0, 6, 17, 18)];
    [bezierPath6 closePath];
    
    UIBezierPath *bezierPath7 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                               radius:10
                                                           startAngle:0
                                                             endAngle:M_PI * 2
                                                            clockwise:YES];
    
    id bezierPath8 = [[NSNull alloc] init];
    
    UIBezierPath *bezierPath9 = [UIBezierPath bezierPathWithRoundedRect:YXCRectMake(0, 0, 30, 54)
                                                      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                            cornerRadii:CGSizeMake(5, 5)];
    
    UIBezierPath *bezierPath10 = [UIBezierPath bezierPathWithRoundedRect:YXCRectMake(0, 0, 57, 57) cornerRadius:3];
    
    id bezierPath11 = [[NSNull alloc] init];
    
    id bezierPath12 = [[NSNull alloc] init];
    
    UIBezierPath *bezierPath13 = [[UIBezierPath alloc] init];
    [bezierPath13 moveToPoint:YXCPointMake(0, 39, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(13, 13, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(38, 0, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(45, 0, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(76, 31, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(76, 64, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(64, 76, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(30, 76, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(0, 45, 76, 76)];
    [bezierPath13 closePath];
    
    UIBezierPath *bezierPath14 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                                radius:40
                                                            startAngle:0
                                                              endAngle:M_PI * 2
                                                             clockwise:YES];
    
    UIBezierPath *bezierPath16 = [[UIBezierPath alloc] init];
    [bezierPath16 moveToPoint:YXCPointMake(0, 31, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(31, 0, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(51, 0, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(51, 63, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(31, 63, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(0, 31, 51, 63)];
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
        @"yx_dynamic_16": bezierPath16,
    };
}

@end
