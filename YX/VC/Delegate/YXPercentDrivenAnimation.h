//
//  YXPercentDrivenAnimation.h
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXPercentDrivenAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic) BOOL interacting;

- (void)wireToViewController:(UIViewController *)viewController;

@end
