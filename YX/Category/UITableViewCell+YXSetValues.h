//
//  UITableViewCell+YXSetValues.h
//  YX
//
//  Created by 杨鑫 on 15/7/17.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning 在这个分类分装公用Cell设置内容的方法，减少控制器的负担

@interface UITableViewCell (YXSetValues)

- (void)bindValuesForTitle:(NSString *)title;

@end
