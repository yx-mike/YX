//
//  YXMotionDynamicItem.h
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


extern CGPoint YXCPointMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
extern CGRect YXCRectMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h);


typedef NS_OPTIONS(NSUInteger, YXMotionDynamicItemType) {
    YXMotionDynamicItemTypeDefault  = 0,
};

@interface YXMotionDynamicItem : UIView

/// item的类别，主要是用于区分，密度，摩擦和弹性值
@property (nonatomic, assign) YXMotionDynamicItemType type;


/// 初始化动力学视图
/// @param frame 大小
/// @param type 类型
/// @param image 图片
/// @param bezierPath 路径，用于碰撞检测
- (instancetype)initWithFrame:(CGRect)frame
                         type:(YXMotionDynamicItemType)type
                        image:(UIImage *)image
                   bezierPath:(UIBezierPath *)bezierPath;

@end

NS_ASSUME_NONNULL_END
