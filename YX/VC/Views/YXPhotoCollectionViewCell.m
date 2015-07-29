//
//  YXPhotoCollectionViewCell.m
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXPhotoCollectionViewCell.h"
//
#import "NSLayoutConstraint+YXCommon.h"

@interface YXPhotoCollectionViewCell ()

@end

@implementation YXPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        self.imageView = imageView;
        imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
        imageView.layer.borderWidth = 5.0f;
        [self.contentView addSubview:imageView];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint viewFillSuperView:imageView];
    }
    return self;
}

@end
