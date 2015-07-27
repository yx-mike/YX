//
//  YXNavigationController.m
//  YX
//
//  Created by 杨鑫 on 15/7/17.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXNavigationController.h"
#import "Storyboard_iOS7_Chapter4_ViewController.h"
//
#import "CustomUnwindSegue.h"


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

#warning 专门storyboard自定义专场写的方法, 这个方法只能写在容器控制器里，比如UINavigationController和UITabBarController等,当没有这些容器，才会写在前面的视图控制器
- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController
                                      fromViewController:(UIViewController *)fromViewController
                                              identifier:(NSString *)identifier
{
    if([toViewController isKindOfClass:[Storyboard_iOS7_Chapter4_ViewController class]]) {
        CustomUnwindSegue *segue = [[CustomUnwindSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
        return segue;
    }
    
    return [[UIStoryboardSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
}

@end
