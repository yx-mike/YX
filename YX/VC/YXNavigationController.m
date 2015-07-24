//
//  YXNavigationController.m
//  YX
//
//  Created by 杨鑫 on 15/7/17.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXNavigationController.h"

@interface YXNavigationController ()

@end

@implementation YXNavigationController

+ (void)initialize
{
    //appear
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = [UIColor whiteColor];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont systemFontOfSize:18]}];
}

@end
