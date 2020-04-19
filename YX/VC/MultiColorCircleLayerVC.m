//
//  MultiColorCircleLayerVC.m
//  YX
//
//  Created by weidian2015090112 on 15/9/2.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "MultiColorCircleLayerVC.h"
//
#import "MultiColorCircleView.h"
#import "YXLoadingSpinner.h"
//
#import "Macros.h"

@interface MultiColorCircleLayerVC ()

@end

@implementation MultiColorCircleLayerVC

- (void)loadView
{
    [super loadView];
    //
    
    CGRect frame = CGRectMake(0, 0, FullScreenWidth/2, FullScreenWidth/2);
    MultiColorCircleView *view = [[MultiColorCircleView alloc] initWithFrame:frame];
    [self.view addSubview:view];
    [view startAnimation];
    
    frame = CGRectMake(FullScreenWidth/2, 0, FullScreenWidth/2, FullScreenWidth/2);
    YXLoadingSpinner *spinnerView = [[YXLoadingSpinner alloc] initWithFrame:frame];
    [self.view addSubview:spinnerView];
    [spinnerView startAnimating];
}

@end
