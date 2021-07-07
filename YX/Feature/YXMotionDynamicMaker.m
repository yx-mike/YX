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


///
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
    NSLog(@"yx02: CMAcceleration(%f, %f, %f)", gravity.x, gravity.y, gravity.z);
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

@end
