//
//  YXLoadingSpinner.h
//  YX
//
//  Created by weidian2015090112 on 2020/4/19.
//  Copyright © 2020 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, YXRotationDirection) {
    YXRotationDirectionClockwise,
    YXRotationDirectionCounterClockwise
};


@interface YXLoadingSpinner : UIView

@property (nonatomic, assign) YXRotationDirection rotationDirection;

@property (nonatomic, assign) CGFloat staticArcLength;

@property (nonatomic, assign) CGFloat minimumArcLength;
@property (nonatomic, assign) CGFloat maximumArcLength;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CFTimeInterval rotationCycleDuration;
@property (nonatomic, assign) CFTimeInterval drawCycleDuration;

@property (nonatomic, strong) CAMediaTimingFunction *drawTimingFunction;

@property (nonatomic, strong) NSArray<UIColor *> *colorSequence UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *backgroundRailColor;

@property (nonatomic, assign, readonly) BOOL isAnimating;

- (void)startAnimating;
- (void)stopAnimating;

+ (CAMediaTimingFunction *)linear;
+ (CAMediaTimingFunction *)easeIn;
+ (CAMediaTimingFunction *)easeOut;
+ (CAMediaTimingFunction *)easeInOut;
+ (CAMediaTimingFunction *)sharpEaseInOut;

@end

NS_ASSUME_NONNULL_END
