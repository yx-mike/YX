//
//  YXMotionDynamicItem.m
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXMotionDynamicItem.h"

static NSDictionary *kImageSizeMap;
static NSDictionary *kImageBezierMap;

@interface YXMotionDynamicItem ()

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, strong) UIBezierPath *bezierPath;

@end

@implementation YXMotionDynamicItem

+ (void)prepareImageSizeMap:(NSDictionary *)imageSizeMap imageBezierMap:(NSDictionary *)imageBezierMap {
    kImageSizeMap = [imageSizeMap copy];
    kImageBezierMap = [imageBezierMap copy];
}

- (instancetype)initWithFrame:(CGRect)frame type:(YXMotionDynamicItemType)type imageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    
    NSValue *sizeValue = kImageSizeMap[imageName];
    if (sizeValue) {
        CGSize imageSize = sizeValue.CGSizeValue;
        
        frame.size.width = imageSize.width;
        frame.size.height = imageSize.height;
    }
    
    UIBezierPath *bezierPath = kImageBezierMap[imageName];
    
    return [self initWithFrame:frame type:type image:image bezierPath:bezierPath];
}

- (instancetype)initWithFrame:(CGRect)frame
                         type:(YXMotionDynamicItemType)type
                        image:(UIImage *)image
                   bezierPath:(UIBezierPath *)bezierPath
{
    if (image == nil) {
        frame = CGRectZero;
        bezierPath = nil;
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        if (image) {
            [self loadViewWithImage:image bounds:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        }
        
        self.bezierPath = bezierPath;
    }
    return self;
}

- (void)loadViewWithImage:(UIImage *)image bounds:(CGRect)bounds {
    if (!image) {
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView = imageView;
    imageView.frame = self.bounds;
    
    [self addSubview:imageView];
}

#pragma mark - UIDynamicItem

- (UIDynamicItemCollisionBoundsType)collisionBoundsType {
    if (self.bezierPath) {
        return UIDynamicItemCollisionBoundsTypePath;
    }
    
    return UIDynamicItemCollisionBoundsTypeRectangle;
}

- (UIBezierPath *)collisionBoundingPath {
    return self.bezierPath;
}

@end
