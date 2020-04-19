//
//  YXLoadingSpinner.m
//  YX
//
//  Created by weidian2015090112 on 2020/4/19.
//  Copyright © 2020 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXLoadingSpinner.h"


@interface YXLoadingSpinner () <CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *foregroundRailLayer;
@property (nonatomic, strong) CAShapeLayer *backgroundRailLayer;

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, assign) BOOL isFirstCycle;
@property (nonatomic, assign) NSUInteger colorIndex;

@end

@implementation YXLoadingSpinner

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
    if (self) {
        [self loadLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadLayer];
    }
    return self;
}

- (void)startAnimating {
    [self stopAnimating];
    
    self.foregroundRailLayer.hidden = NO;
    self.backgroundRailLayer.hidden = NO;
    
    self.isAnimating = YES;
    self.isFirstCycle = YES;
    self.foregroundRailLayer.strokeEnd = [self proportionFromArcLengthRadians:self.minimumArcLength];
    
    self.colorIndex = 0;
    self.foregroundRailLayer.strokeColor = [self.colorSequence[self.colorIndex] CGColor];
    
    [self addAnimationsToLayer:self.foregroundRailLayer reverse:NO rotationOffset:-M_PI_2];
}

- (void)addAnimationsToLayer:(CAShapeLayer *)layer reverse:(BOOL)reverse rotationOffset:(CGFloat)rotationOffset {
    
    CABasicAnimation *strokeAnimation;
    CGFloat strokeDuration = self.drawCycleDuration;
    CGFloat currentDistanceToStrokeStart = 2 * M_PI * layer.strokeStart;
    
    if (reverse) {
        [CATransaction begin];
        
        strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        CGFloat newStrokeStart = self.maximumArcLength - self.minimumArcLength;
        
        layer.strokeEnd = [self proportionFromArcLengthRadians:self.maximumArcLength];
        layer.strokeStart = [self proportionFromArcLengthRadians:newStrokeStart];
        
        strokeAnimation.fromValue = @(0);
        strokeAnimation.toValue = @([self proportionFromArcLengthRadians:newStrokeStart]);
        
    } else {
        CGFloat strokeFromValue = self.minimumArcLength;
        CGFloat rotationStartRadians = rotationOffset;
        
        if (self.isFirstCycle) {
            if (self.staticArcLength > 0) {
                if (self.staticArcLength > self.maximumArcLength) {
                    NSLog(@"DRPLoadingSpinner: staticArcLength is set to a value greater than maximumArcLength. You probably didn't mean to do this.");
                }
                
                strokeFromValue = self.staticArcLength;
                strokeDuration *= (self.staticArcLength / self.maximumArcLength);
            }
            
            self.isFirstCycle = NO;
        } else {
            rotationStartRadians += currentDistanceToStrokeStart;
        }
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = @(rotationStartRadians);
        rotationAnimation.toValue = @(rotationStartRadians + (2 * M_PI));
        rotationAnimation.timingFunction = [YXLoadingSpinner linear];
        rotationAnimation.duration = self.rotationCycleDuration;
        rotationAnimation.repeatCount = HUGE_VALF;
        rotationAnimation.fillMode = kCAFillModeForwards;
        
        [layer removeAnimationForKey:@"rotation"];
        [layer addAnimation:rotationAnimation forKey:@"rotation"];
        
        
        [CATransaction begin];
        
        strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeAnimation.fromValue = @([self proportionFromArcLengthRadians:strokeFromValue]);
        strokeAnimation.toValue = @([self proportionFromArcLengthRadians:self.maximumArcLength]);
        
        layer.strokeStart = 0;
        layer.strokeEnd = [strokeAnimation.toValue doubleValue];
    }
    
    strokeAnimation.delegate = self;
    strokeAnimation.fillMode = kCAFillModeForwards;
    strokeAnimation.timingFunction = self.drawTimingFunction;
    [CATransaction setAnimationDuration:strokeDuration];
    
    [layer removeAnimationForKey:@"stroke"];
    [layer addAnimation:strokeAnimation forKey:@"stroke"];
    
    [CATransaction commit];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished {
    if (finished && [anim isKindOfClass:[CABasicAnimation class]]) {
        CABasicAnimation *basicAnim = (CABasicAnimation *)anim;
        BOOL isStrokeStart = [basicAnim.keyPath isEqualToString:@"strokeStart"];
        BOOL isStrokeEnd = [basicAnim.keyPath isEqualToString:@"strokeEnd"];
        
        CGFloat rotationOffset = fmodf([[self.foregroundRailLayer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue], 2 * M_PI);
        [self addAnimationsToLayer:self.foregroundRailLayer reverse:isStrokeEnd rotationOffset:rotationOffset];
        
        if (isStrokeStart) {
            [self advanceColorSequence];
        }
    }
}

- (void)stopAnimating {
    self.isAnimating = NO;
    
    self.foregroundRailLayer.hidden = YES;
    self.backgroundRailLayer.hidden = YES;
    
    [self.foregroundRailLayer removeAllAnimations];
}

- (void)advanceColorSequence {
    self.colorIndex = (self.colorIndex + 1) % self.colorSequence.count;
    self.foregroundRailLayer.strokeColor = [self.colorSequence[self.colorIndex] CGColor];
}

- (CGFloat)proportionFromArcLengthRadians:(CGFloat)radians {
    return ((fmodf(radians, 2 * M_PI)) / (2 * M_PI));
}

#pragma mark - Setter

- (void)setRotationDirection:(YXRotationDirection)rotationDirection {
    _rotationDirection = rotationDirection;
    
    switch (rotationDirection) {
        case YXRotationDirectionCounterClockwise:
            self.layer.affineTransform = CGAffineTransformScale(CGAffineTransformIdentity, -1, 1);
            break;
        case YXRotationDirectionClockwise:
        default:
            self.layer.affineTransform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            break;
    }
}

- (void)setStaticArcLength:(CGFloat)staticArcLength {
    _staticArcLength = staticArcLength;
    
    if (!self.isAnimating) {
        self.foregroundRailLayer.hidden = NO;
        self.backgroundRailLayer.hidden = NO;
        self.foregroundRailLayer.strokeColor = self.colorSequence.firstObject.CGColor;
        self.foregroundRailLayer.strokeStart = 0;
        self.foregroundRailLayer.strokeEnd = [self proportionFromArcLengthRadians:staticArcLength];
        self.foregroundRailLayer.transform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 0, 1);
    }
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.foregroundRailLayer.lineWidth = lineWidth;
    self.backgroundRailLayer.lineWidth = lineWidth;
}

- (void)setBackgroundRailColor:(UIColor *)backgroundRailColor {
    self.backgroundRailLayer.strokeColor = backgroundRailColor.CGColor;
}

#pragma mark - Getter

- (CGFloat)lineWidth {
    return self.foregroundRailLayer.lineWidth;
}

- (UIColor *)backgroundRailColor {
    return [UIColor colorWithCGColor:self.backgroundRailLayer.strokeColor];
}

#pragma mark - Frame

- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if (self.window && self.isAnimating) {
        [self startAnimating];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (self.superview && self.isAnimating) {
        [self startAnimating];
    }
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(40, 40);
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    [self refreshCircleFrame];
}

- (void)refreshCircleFrame {
    CGFloat sideLen = MIN(self.layer.frame.size.width, self.layer.frame.size.height) - (2 * self.lineWidth);
    CGFloat xOffset = ceilf((self.frame.size.width - sideLen) / 2.0);
    CGFloat yOffset = ceilf((self.frame.size.height - sideLen) / 2.0);
    
    self.foregroundRailLayer.frame = CGRectMake(xOffset, yOffset, sideLen, sideLen);
    UIBezierPath *railPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sideLen, sideLen)];
//    railPath.lineCapStyle = kCGLineCapRound; //线条拐角
//    railPath.lineJoinStyle = kCGLineCapRound; //终点处理
    self.foregroundRailLayer.path = railPath.CGPath;
    
    self.backgroundRailLayer.frame = CGRectMake(xOffset, yOffset, sideLen, sideLen);
    self.backgroundRailLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, sideLen, sideLen)].CGPath;
}

#pragma mark - Layer

- (void)loadLayer {
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    
    self.foregroundRailLayer = [[CAShapeLayer alloc] init];
    self.backgroundRailLayer = [[CAShapeLayer alloc] init];
    
    self.rotationDirection = YXRotationDirectionClockwise;
    self.drawCycleDuration = 0.75;
    self.rotationCycleDuration = 1.5;
    self.staticArcLength = 0;
    self.maximumArcLength = (2 * M_PI) - M_PI_4;
    self.minimumArcLength = 0.1;
    self.lineWidth = 2.;
    
    self.drawTimingFunction = [YXLoadingSpinner easeInOut];
    
    self.colorSequence = @[[UIColor redColor],
                           [UIColor orangeColor],
                           [UIColor purpleColor],
                           [UIColor blueColor]];
    
    self.backgroundRailLayer.fillColor = [UIColor clearColor].CGColor;
    self.backgroundRailLayer.strokeColor = [UIColor clearColor].CGColor;
    self.backgroundRailLayer.hidden = YES;
    
    self.foregroundRailLayer.fillColor = [UIColor clearColor].CGColor;
    self.foregroundRailLayer.anchorPoint = CGPointMake(.5, .5);
    self.foregroundRailLayer.strokeColor = self.colorSequence.firstObject.CGColor;
    self.foregroundRailLayer.hidden = YES;
    
    self.foregroundRailLayer.lineCap = kCALineCapRound;
    self.foregroundRailLayer.lineJoin = kCALineJoinRound;
    
    self.backgroundRailLayer.actions = @{@"lineWidth": [NSNull null],
                                         @"strokeEnd": [NSNull null],
                                         @"strokeStart": [NSNull null],
                                         @"transform": [NSNull null],
                                         @"hidden": [NSNull null]};
    
    self.foregroundRailLayer.actions = @{@"lineWidth": [NSNull null],
                                         @"strokeEnd": [NSNull null],
                                         @"strokeStart": [NSNull null],
                                         @"transform": [NSNull null],
                                         @"hidden": [NSNull null]};
    
    // If we have an apperance specified, then use it to override the defaults.
    if(nil != [YXLoadingSpinner appearance].colorSequence) {
        self.colorSequence = [YXLoadingSpinner appearance].colorSequence;
    }
    
    [self refreshCircleFrame];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    
    if (!self.backgroundRailLayer.superlayer) {
        [self.layer addSublayer:self.backgroundRailLayer];
    }
    
    if (!self.foregroundRailLayer.superlayer) {
        [self.layer addSublayer:self.foregroundRailLayer];
    }
}


+ (CAMediaTimingFunction *)linear {
    return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
}

+ (CAMediaTimingFunction *)easeIn {
    return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
}

+ (CAMediaTimingFunction *)easeOut {
    return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
}

+ (CAMediaTimingFunction *)easeInOut {
    return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
}

+ (CAMediaTimingFunction *)sharpEaseInOut {
    return [CAMediaTimingFunction functionWithControlPoints:0.62 :0.0 :0.38 :1.0];
}

@end
