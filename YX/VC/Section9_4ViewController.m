//
//  Section9_4ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section9_4ViewController.h"

@interface Section9_4ViewController ()

@property (weak, nonatomic) CALayer *topLayer;
@property (weak, nonatomic) CALayer *bottomLayer;
@property (weak, nonatomic) CALayer *leftLayer;
@property (weak, nonatomic) CALayer *rightLayer;
@property (weak, nonatomic) CALayer *frontLayer;
@property (weak, nonatomic) CALayer *backLayer;

- (CALayer *)layerWithColor:(UIColor *)color transform:(CATransform3D)transform;

@end

static const CGFloat kSize = 100.;
static const CGFloat kPanScale = 1./66.;

@implementation Section9_4ViewController

CATransform3D MakePerspetiveTransform(void);
CATransform3D MakePerspetiveTransform() {
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1./2000.;
    return perspective;
}

- (void)loadView
{
    [super loadView];
    //
    self.title = @"三维动画";
    
    CATransform3D transform;
    transform = CATransform3DMakeTranslation(0, -kSize/2, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1.0, 0, 0);
    self.topLayer = [self layerWithColor:[UIColor redColor] transform:transform];
    
    transform = CATransform3DMakeTranslation(0, kSize/2, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1.0, 0, 0);
    self.bottomLayer = [self layerWithColor:[UIColor greenColor] transform:transform];
    
    transform = CATransform3DMakeTranslation(kSize/2, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    self.rightLayer = [self layerWithColor:[UIColor blueColor] transform:transform];
    
    transform = CATransform3DMakeTranslation(-kSize/2, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    self.leftLayer = [self layerWithColor:[UIColor cyanColor] transform:transform];
    
    transform = CATransform3DMakeTranslation(0, 0, -kSize/2);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 0, 0);
    self.backLayer = [self layerWithColor:[UIColor yellowColor] transform:transform];
    
    transform = CATransform3DMakeTranslation(0, 0, kSize/2);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 0, 0);
    self.frontLayer = [self layerWithColor:[UIColor magentaColor] transform:transform];
    
    self.view.layer.sublayerTransform = MakePerspetiveTransform();
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    UIGestureRecognizer *g = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:g];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    
    CATransform3D transform = MakePerspetiveTransform();
    transform = CATransform3DRotate(transform, kPanScale * translation.x, 0, 1, 0);
    transform = CATransform3DRotate(transform, -kPanScale * translation.y, 1, 0, 0);
    self.view.layer.sublayerTransform = transform;
}

- (CALayer *)layerWithColor:(UIColor *)color transform:(CATransform3D)transform
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [color CGColor];
    layer.bounds = CGRectMake(0, 0, kSize, kSize);
    layer.position = self.view.center;
    layer.transform = transform;
    [self.view.layer addSublayer:layer];
    return layer;
}

@end
