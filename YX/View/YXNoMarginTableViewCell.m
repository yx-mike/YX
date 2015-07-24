//
//  YXNoMarginTableViewCell.m
//  YX
//
//  Created by 杨鑫 on 15/7/18.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXNoMarginTableViewCell.h"

@interface YXNoMarginTableViewCell ()

- (void)prepMargin;

@end

@implementation YXNoMarginTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepMargin];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self prepMargin];
}

#pragma mark - Self

- (void)bindValuesForTitle:(NSString *)title
{
    self.textLabel.text = title;
}

#pragma mark - extension class

- (void)prepMargin
{
    #warning 去除TableCell与左边的留白
    [self setSeparatorInset:UIEdgeInsetsZero];
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end