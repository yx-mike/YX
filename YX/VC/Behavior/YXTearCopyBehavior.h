//
//  YXTearCopyBehavior.h
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXDragView;

typedef void(^TearOffHandler)(YXDragView *dragView);

@interface YXTearCopyBehavior : UIDynamicBehavior

- (instancetype) initWithDragView:(YXDragView *)view handle:(TearOffHandler)handle;

@end
