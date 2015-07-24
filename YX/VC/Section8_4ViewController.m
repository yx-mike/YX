//
//  Section8_4ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/19.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section8_4ViewController.h"
//
#import "Macros.h"
#import "Constant.h"

@interface DrawingView : UIView

@end

@implementation DrawingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = AppBackgroundColor;
    }
    return self;
}

- (UIImage *)reverseImageForText:(NSString *)text {
    const size_t kImageWidth = 200;
    const size_t kImageHeight = 200;
    CGImageRef textImage = NULL;
    UIFont *font = [UIFont boldSystemFontOfSize:17.0];
    
    #warning UIImage context
    UIGraphicsBeginImageContext(CGSizeMake(kImageWidth, kImageHeight));
    [text drawInRect:CGRectMake(0, 0, kImageWidth, kImageHeight) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName: [UIColor redColor]}];
    textImage = UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:textImage scale:1.0 orientation:UIImageOrientationUpMirrored];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor colorWithRed:0 green:0 blue:1 alpha:0.1] set];
    // Generate a bitmap, reverse it and draw it
    [[self reverseImageForText:@"Hello World"] drawAtPoint:CGPointMake(50, 150)];
    UIRectFillUsingBlendMode(CGRectMake(100, 100, 100, 100),kCGBlendModeNormal);
}

@end

@interface Section8_4ViewController ()

@end

@implementation Section8_4ViewController

- (void)loadView
{
    [super loadView];
    self.title = @"Drawing";
    //
    [self.view addSubview:[[DrawingView alloc] initWithFrame:CGRectMake(0, 0, FullkScreenWidth, FullScreenHeight-NavigationHeight)]];
}

@end
