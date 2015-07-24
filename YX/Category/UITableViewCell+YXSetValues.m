//
//  UITableViewCell+YXSetValues.m
//  YX
//
//  Created by 杨鑫 on 15/7/17.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "UITableViewCell+YXSetValues.h"

@implementation UITableViewCell (YXSetValues)

- (void)bindValuesForTitle:(NSString *)title
{
    self.textLabel.text = title;
}

@end
