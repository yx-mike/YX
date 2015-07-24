//
//  CALayer+YXAmimation.h
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (YXAmimation)

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath duration:(CFTimeInterval)duration delay:(CFTimeInterval)delay;

@end
