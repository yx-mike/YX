//
//  Section19_iOS7_4ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_4ViewController.h"
//
#import "YXDragView.h"
//
#import "YXDefaultDynamicBehavior.h"
#import "YXTearCopyBehavior.h"

@interface Section19_iOS7_4ViewController ()

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (weak, nonatomic) YXDefaultDynamicBehavior *defaultBehavior;

@end

@implementation Section19_iOS7_4ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.title = @"例子1";
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    YXDragView *dragView = [[YXDragView alloc] initWithFrame:CGRectMake(7, 7, 66, 66) animator:self.dynamicAnimator];
    dragView.alpha = .5;
    [self.view addSubview:dragView];
    
    // 用YXDefaultDynamicBehavior包了两个行为，碰撞和重力
    YXDefaultDynamicBehavior *defaultBehavior = [[YXDefaultDynamicBehavior alloc] init];
    self.defaultBehavior = defaultBehavior;
    [self.dynamicAnimator addBehavior:defaultBehavior];
    
    YXTearCopyBehavior *tearOffBehavior = [[YXTearCopyBehavior alloc] initWithDragView:dragView handle:^(YXDragView *dragView){
        dragView.alpha = 1;
        [self.defaultBehavior addItem:dragView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearDragView:)];
        tap.numberOfTapsRequired = 2;
        [dragView addGestureRecognizer:tap];
    }];
    [self.dynamicAnimator addBehavior:tearOffBehavior];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //
    [self.dynamicAnimator removeAllBehaviors];
}

#pragma mark - UITapGestureRecognizer

- (void)clearDragView:(UITapGestureRecognizer *)g
{
    UIView *view = g.view;
    
    // Calculate the new views.
    NSArray *subviews = [self sliceView:view intoRows:6 columns:6];
    
    // Create a new animator
    UIDynamicAnimator *trashAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Create a new default behavior
    YXDefaultDynamicBehavior *defaultBehavior = [[YXDefaultDynamicBehavior alloc] init];
    
    for (UIView *subview in subviews) {
        // Add the new "exploded" view to the hierarchy
        [self.view addSubview:subview];
        [defaultBehavior addItem:subview];
        
        // Create a push animation for each
        UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[subview] mode:UIPushBehaviorModeInstantaneous];
        [push setPushDirection:CGVectorMake((float)rand()/RAND_MAX - .5, (float)rand()/RAND_MAX - .5)];
        [trashAnimator addBehavior:push];
        
        // Fade out the pieces as they fly around.
        // At the end, remove them. Referencing trashAnimator here
        // also allows ARC to keep it around without an ivar.
        [UIView animateWithDuration:1 animations:^{
            subview.alpha = 0;
        } completion:^(BOOL didComplete){
            [subview removeFromSuperview];
            [trashAnimator removeBehavior:push];
        }];
    }
    
    // Remove the old view
    [self.defaultBehavior removeItem:view];
    [view removeFromSuperview];
}

- (NSArray *)sliceView:(UIView *)view intoRows:(NSUInteger)rows columns:(NSInteger)columns
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    CGImageRef image = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    
    NSMutableArray *views = [NSMutableArray new];
    CGFloat width = CGImageGetWidth(image);
    CGFloat height = CGImageGetHeight(image);
    for (NSUInteger row = 0; row < rows; ++row) {
        for (NSUInteger column = 0; column < columns; ++column) {
            CGRect rect = CGRectMake(column * (width / columns), row * (height / rows), width / columns, height / rows);
            CGImageRef subimage = CGImageCreateWithImageInRect(image, rect);
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageWithCGImage:subimage]];
            CGImageRelease(subimage); subimage = NULL;
            
            imageView.frame = CGRectOffset(rect, CGRectGetMinX(view.frame), CGRectGetMinY(view.frame));
            [views addObject:imageView];
        }
    }
    
    return views;
}

@end
