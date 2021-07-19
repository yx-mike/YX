//
//  YXMotionDynamicMaker.m
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

#import "YXMotionDynamicMaker.h"
#import "YXMotionDynamicItem.h"


/**
 UIDynamicItemBehavior
 elasticity 弹性，有效范围是从 0.0（碰撞时无反弹）到 1.0（完全弹性碰撞）。
 friction 当两个相互滑动时行为的动态项目的线性阻力。默认值为 0.0，对应于无摩擦。 使用 1.0 的值来应用强摩擦。 要施加更大的摩擦力，您可以使用更高的数字。
 density 相对质量密度。密度为 1.0 的 100 x 100 点动态项目，您对其施加 1.0 级的力（通过推动行为），以每秒 100 点的速度加速。
 resistance 行为的动态项目的线性阻力，随着时间的推移降低它们的线性速度。默认值为 0.0，对应于无摩擦。 使用 1.0 的值来应用强摩擦。 要施加更大的摩擦力，您可以使用更高的数字。
 angularResistance 行为的动态项目的角阻力。有效范围是 0 到 CGFLOAT_MAX。 值越大，角阻尼越大，旋转速度越快停止。
 charge 好像跟电磁场相关
 anchored 锚定项目参与碰撞但不受这些碰撞的影响。 相反，该项目的行为类似于碰撞边界。 此属性的默认值为 NO。
 allowsRotation 指定行为的动态项目是否允许旋转。Default value is YES
 // 线性速度
 - (void)addLinearVelocity:(CGPoint)velocity forItem:(id <UIDynamicItem>)item;
 // 转动速度
 - (void)addAngularVelocity:(CGFloat)velocity forItem:(id <UIDynamicItem>)item;
 
 
 UICollisionBehavior
 collisionMode 碰撞，主要是边界是否参与碰撞
 translatesReferenceBoundsIntoBoundary 指定基于参考系的边界是否处于活动状态。
 collisionDelegate 碰撞前后的代理
 // 给边界设置内边距
 - (void)setTranslatesReferenceBoundsIntoBoundaryWithInsets:(UIEdgeInsets)insets;
 // 向碰撞行为添加指定为贝塞尔曲线的碰撞边界。这个整个区域的边界，就像台球桌
 - (void)addBoundaryWithIdentifier:(id <NSCopying>)identifier forPath:(UIBezierPath *)bezierPath;
 
 
 UIGravityBehavior
 gravityDirection 重力的方向和大小，用向量表示。
 angle 重力矢量的方向，以参考坐标系中的弧度表示。
 magnitude 重力矢量的大小。
 
 
 UIPushBehavior
 mode 模式，持续力或者瞬间力
 active
 angle 行为的力矢量的角度（以弧度为单位）。
 magnitude 推动行为的力矢量的大小。
 pushDirection 行为的力向量的方向，表示为 x 和 y 分量并使用标准 UIKit 几何图形。
 */

@interface YXMotionDynamicMaker () <UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) UIView *refView;

// 基本属性，密度、摩擦、弹性。
// 可能根据item具体归类，确定几个不同的UIDynamicItemBehavior
@property (nonatomic, weak) UIDynamicItemBehavior *baseBehavior;

// 碰撞
@property (nonatomic, weak) UICollisionBehavior *collisionBehavior;

// 重力行为
@property (nonatomic, weak) UIGravityBehavior *gravityBehavior;

// 滑动，作用力.
// 依赖陀螺仪，所以所有item的力的相对指都是一样的
@property (nonatomic, strong) CMMotionManager *motionManager;
// 更重力感应数组，保留几3位小数
@property (nonatomic, assign) NSInteger gX;
@property (nonatomic, assign) NSInteger gY;

// 拥有默认Behavior的视图
@property (nonatomic, strong) NSPointerArray *weakItemList;

@end

@implementation YXMotionDynamicMaker

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:view];
        self.refView = view;
        self.weakItemList = [NSPointerArray weakObjectsPointerArray];
        
        self.gX = NSIntegerMax;
        self.gY = NSIntegerMax;
        
        [self initBehaviors];
    }
    return self;
}

- (void)initBehaviors {
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] init];
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] init];
    
    [self.dynamicAnimator addBehavior:collisionBehavior];
    [self.dynamicAnimator addBehavior:gravityBehavior];
    
    self.collisionBehavior = collisionBehavior;
    self.gravityBehavior = gravityBehavior;
}

- (void)loadItems {
    NSDictionary *sizeMap = [self prepareSizeMap];
    NSDictionary *bezierMap = [self prepareBezierMap];
    
    // 逐个动画插入，动画结束后再加上行为
    __block double delayTime = 0;
    [sizeMap enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSValue *obj, BOOL *stop) {
        CGSize size = obj.CGSizeValue;
        CGRect rect = CGRectMake(random() % 200, -size.height, size.width, size.height);
        UIImage *image = [UIImage imageNamed:key];
        UIBezierPath *bezierPath = bezierMap[key];
        
        dispatch_time_t delayGCDTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
        dispatch_after(delayGCDTime, dispatch_get_main_queue(), ^{
            YXMotionDynamicItem *itemView;
            itemView = [[YXMotionDynamicItem alloc] initWithFrame:rect
                                                             type:YXMotionDynamicItemTypeDefault
                                                            image:image
                                                       bezierPath:bezierPath];
            
            [self addItemView:itemView toView:self.refView];
        });
        
        delayTime += 0.25;
    }];
}

- (void)addItemView:(YXMotionDynamicItem *)itemView toView:(UIView *)view {
    [view addSubview:itemView];
    [view layoutIfNeeded];
    
    CGRect frame = itemView.frame;
    frame.origin.y = 0;
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        itemView.frame = frame;
    } completion:^(BOOL finished) {
        [self addItem:itemView];
    }];
}

- (void)startMotion {
    if (self.motionManager) {
        return;
    }
    
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    // 更新频率是10Hz，先看看每秒10次的效果
    motionManager.accelerometerUpdateInterval = 1.f/10;
    
    //Push方式获取和处理数据
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 在操作队列和指定的处理程序上启动陀螺仪更新。
//    if (motionManager.isGyroAvailable) {
//        [motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData *gyroData, NSError *error) {
//            if (error) {
//                return;
//            }
//
//            CMRotationRate rotationRate = gyroData.rotationRate;
//            NSLog(@"yx02: CMRotationRate(%f, %f, %f)", rotationRate.x, rotationRate.y, rotationRate.z);
//        }];
//
//        self.motionManager = motionManager;
//    }
    
    // 在操作队列和指定的处理程序上启动加速度计更新。
//    if (motionManager.isAccelerometerAvailable) {
//        [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
//            if (error) {
//                return;
//            }
//
//            CMAcceleration acceleration = accelerometerData.acceleration;
//            NSLog(@"yx02: CMAcceleration(%f, %f, %f)", acceleration.x, acceleration.y, acceleration.z);
//        }];
//
//        self.motionManager = motionManager;
//    }
    
    // 在操作队列上启动设备运动更新并使用指定的块处理程序。
    if (motionManager.isDeviceMotionAvailable) {
        __weak typeof(self) weakself = self;
        [motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *motion, NSError *error) {
            if (error) {
                return;
            }
            
            [weakself updateDeviceMotion:motion];
        }];

        self.motionManager = motionManager;
    }
}

- (void)updateDeviceMotion:(CMDeviceMotion *)motion {
    /**
     CMAttitude,姿势，设备在某个时间点相对于已知参考系的方向。(朝向)
     下面有三种数学表示方式，我表示没学过。欧拉角、旋转矩阵、四元数，😂😂😂😂😂。
     */
    /// 姿态的第一种数学表示：欧拉角（滚动、俯仰和偏航值）
//    CMAttitude *attitude = motion.attitude;
//    attitude.roll;
//    attitude.pitch;
//    attitude.yaw;
    /// 姿态的第二种数学表示：旋转矩阵（线性代数中的旋转矩阵描述了物体在三维欧几里得空间中的旋转）
//    CMRotationMatrix rotationMatrix = attitude.rotationMatrix;
    /// 姿态的第三种数学表示：四元数
//    CMQuaternion quaternion = attitude.quaternion;
    
    /// 设备的转速。
//    CMRotationRate rotationRate = motion.rotationRate;
    
    /// 在设备的参考系中表示的重力加速度矢量。
    CMAcceleration gravity = motion.gravity;
//    NSLog(@"yx02: CMAcceleration(%f, %f, %f)", gravity.x, gravity.y, gravity.z);
    NSInteger gX = gravity.x * 1000;
    NSInteger gY = gravity.y * 1000;
    if (self.gX == gX && self.gY == gY) {
        return;
    }
    self.gX = gX;
    self.gY = gY;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.gravityBehavior setGravityDirection:CGVectorMake(gravity.x, -gravity.y)];
    });
    
    /// 相对于当前参考系的航向角（以度为单位）。
//    double heading = motion.heading;
    
//    if (@available(iOS 14.0, *)) {
        /// 计算设备运动数据的传感器的位置。
//        CMDeviceMotionSensorLocation sensorLocation = motion.sensorLocation;
//    } else {
        // Fallback on earlier versions
//    }
}

- (void)stopMotion {
    if (!self.motionManager) {
        return;
    }
    
    [self.motionManager stopDeviceMotionUpdates];
    
    self.motionManager = nil;
}

#pragma mark - Public

- (void)addItem:(id<UIDynamicItem>)item {
    NSArray *allObjects = self.weakItemList.allObjects;
    if ([allObjects containsObject:item]) {
        return;
    }
    [self.weakItemList addPointer:(__bridge void * _Nullable)(item)];
    
    [self.collisionBehavior addItem:item];
    [self.gravityBehavior addItem:item];
}

#pragma mark - Item Data

- (NSDictionary *)prepareSizeMap {
    return @{
        @"yx_dynamic_1": [NSValue valueWithCGSize:CGSizeMake(12, 18)],
        @"yx_dynamic_2": [NSValue valueWithCGSize:CGSizeMake(10, 18)],
        @"yx_dynamic_3": [NSValue valueWithCGSize:CGSizeMake(13, 18)],
        @"yx_dynamic_4": [NSValue valueWithCGSize:CGSizeMake(16, 16)],
        @"yx_dynamic_5": [NSValue valueWithCGSize:CGSizeMake(16.5, 16.5)],
        @"yx_dynamic_6": [NSValue valueWithCGSize:CGSizeMake(17, 18)],
        @"yx_dynamic_7": [NSValue valueWithCGSize:CGSizeMake(15, 15)],
        @"yx_dynamic_8": [NSValue valueWithCGSize:CGSizeMake(75, 25)],
        @"yx_dynamic_9": [NSValue valueWithCGSize:CGSizeMake(30, 54)],
        @"yx_dynamic_10": [NSValue valueWithCGSize:CGSizeMake(57, 57)],
        @"yx_dynamic_11": [NSValue valueWithCGSize:CGSizeMake(15, 10)],
        @"yx_dynamic_12": [NSValue valueWithCGSize:CGSizeMake(51, 18)],
        @"yx_dynamic_13": [NSValue valueWithCGSize:CGSizeMake(76, 76)],
        @"yx_dynamic_14": [NSValue valueWithCGSize:CGSizeMake(80, 80)],
        @"yx_dynamic_16": [NSValue valueWithCGSize:CGSizeMake(51, 63)],
    };
}

- (NSDictionary *)prepareBezierMap {
    UIBezierPath *bezierPath1 = [[UIBezierPath alloc] init];
    [bezierPath1 moveToPoint:YXCPointMake(0, 4, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(9, 0, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(10, 0, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(12, 4, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(12, 8, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(10, 18, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(2, 18, 12, 18)];
    [bezierPath1 addLineToPoint:YXCPointMake(0, 8, 12, 18)];
    [bezierPath1 closePath];
    
    UIBezierPath *bezierPath2 = [[UIBezierPath alloc] init];
    [bezierPath2 moveToPoint:YXCPointMake(0, 10, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(2, 2, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(3, 0, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(7, 0, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(8, 2, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(10, 10, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(10, 16, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(8, 18, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(2, 18, 10, 18)];
    [bezierPath2 addLineToPoint:YXCPointMake(0, 16, 10, 18)];
    [bezierPath2 closePath];
    
    UIBezierPath *bezierPath3 = [[UIBezierPath alloc] init];
    [bezierPath3 moveToPoint:YXCPointMake(0, 8, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(2, 3, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(5, 0, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(8, 0, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(11, 3, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(13, 8, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(13, 15, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(11, 18, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(2, 18, 13, 18)];
    [bezierPath3 addLineToPoint:YXCPointMake(0, 16, 13, 18)];
    [bezierPath3 closePath];
    
    UIBezierPath *bezierPath4 = [[UIBezierPath alloc] init];
    [bezierPath4 moveToPoint:YXCPointMake(0, 5, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(7, 0, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(9, 0, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(16, 5, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(16, 8, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(14, 14, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(13, 16, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(4, 16, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(2, 14, 16, 16)];
    [bezierPath4 addLineToPoint:YXCPointMake(0, 8, 16, 16)];
    [bezierPath4 closePath];
    
    UIBezierPath *bezierPath5 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                               radius:11
                                                           startAngle:0
                                                             endAngle:M_PI * 2
                                                            clockwise:YES];
    
    UIBezierPath *bezierPath6 = [[UIBezierPath alloc] init];
    [bezierPath6 moveToPoint:YXCPointMake(0, 3, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(1, 2, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(4, 0, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(12, 0, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(16, 3, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(17, 8, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(17, 12, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(12, 18, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(4, 18, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(1, 16, 17, 18)];
    [bezierPath6 addLineToPoint:YXCPointMake(0, 6, 17, 18)];
    [bezierPath6 closePath];
    
    UIBezierPath *bezierPath7 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                               radius:10
                                                           startAngle:0
                                                             endAngle:M_PI * 2
                                                            clockwise:YES];
    
    id bezierPath8 = [[NSNull alloc] init];
    
    UIBezierPath *bezierPath9 = [UIBezierPath bezierPathWithRoundedRect:YXCRectMake(0, 0, 30, 54)
                                                      byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                                            cornerRadii:CGSizeMake(5, 5)];
    
    UIBezierPath *bezierPath10 = [UIBezierPath bezierPathWithRoundedRect:YXCRectMake(0, 0, 57, 57) cornerRadius:3];
    
    id bezierPath11 = [[NSNull alloc] init];
    
    id bezierPath12 = [[NSNull alloc] init];
    
    UIBezierPath *bezierPath13 = [[UIBezierPath alloc] init];
    [bezierPath13 moveToPoint:YXCPointMake(0, 39, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(13, 13, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(38, 0, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(45, 0, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(76, 31, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(76, 64, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(64, 76, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(30, 76, 76, 76)];
    [bezierPath13 addLineToPoint:YXCPointMake(0, 45, 76, 76)];
    [bezierPath13 closePath];
    
    UIBezierPath *bezierPath14 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0)
                                                                radius:40
                                                            startAngle:0
                                                              endAngle:M_PI * 2
                                                             clockwise:YES];
    
    UIBezierPath *bezierPath16 = [[UIBezierPath alloc] init];
    [bezierPath16 moveToPoint:YXCPointMake(0, 31, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(31, 0, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(51, 0, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(51, 63, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(31, 63, 51, 63)];
    [bezierPath16 addLineToPoint:YXCPointMake(0, 31, 51, 63)];
    [bezierPath16 closePath];
    
    return @{
        @"yx_dynamic_1": bezierPath1,
        @"yx_dynamic_2": bezierPath2,
        @"yx_dynamic_3": bezierPath3,
        @"yx_dynamic_4": bezierPath4,
        @"yx_dynamic_5": bezierPath5,
        @"yx_dynamic_6": bezierPath6,
        @"yx_dynamic_7": bezierPath7,
        @"yx_dynamic_8": bezierPath8,
        @"yx_dynamic_9": bezierPath9,
        @"yx_dynamic_10": bezierPath10,
        @"yx_dynamic_11": bezierPath11,
        @"yx_dynamic_12": bezierPath12,
        @"yx_dynamic_13": bezierPath13,
        @"yx_dynamic_14": bezierPath14,
        @"yx_dynamic_16": bezierPath16,
    };
}

@end
