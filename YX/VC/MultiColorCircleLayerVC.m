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
//
#import "Macros.h"

@interface MultiColorCircleLayerVC ()

@end

@implementation MultiColorCircleLayerVC

- (void)loadView
{
    [super loadView];
    //
    
    MultiColorCircleView *view = [[MultiColorCircleView alloc] initWithFrame:CGRectMake(0, 0, FullScreenWidth, FullScreenHeight-64)];
    [self.view addSubview:view];
    [view startAnimation];
}

@end
