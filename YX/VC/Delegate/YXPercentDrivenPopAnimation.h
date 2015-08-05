//
//  YXPercentDrivenPopAnimation.h
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXPercentDrivenPopAnimation : UIPercentDrivenInteractiveTransition

@property (nonatomic) BOOL interacting;

- (void)wireToViewController:(UINavigationController *)navVC;

@end
