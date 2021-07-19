//
//  YXNavigationControllerDelegate.m
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXNavigationControllerDelegate.h"
//
#import "YXPushVCCubeAnimation.h"
#import "YXPopVCCubeAnimation.h"


@interface YXNavigationControllerDelegate ()

@property (nonatomic, weak) UINavigationController *navVC;

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> pushAnimation;
@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> popAnimation;
@property (strong, nonatomic) YXPercentDrivenPopAnimation *popPercentDriven;

@end

@implementation YXNavigationControllerDelegate

- (instancetype)initWithNav:(UINavigationController *)navVC {
    self = [super init];
    if (self) {
        self.navVC = navVC;
        
        [self setAnimationStyle:YXNavigationAnimationStyle1];
        
        self.popPercentDriven = [[YXPercentDrivenPopAnimation alloc] init];
    }
    return self;
}

- (void)setAnimationStyle:(YXNavigationAnimationStyle)style {
    switch (style) {
        case YXNavigationAnimationStyle1:{
            self.pushAnimation = [[YXPushVCAnimation alloc] initWithControllerDelegate:self];
            self.popAnimation = [[YXPopVCAnimation alloc] initWithControllerDelegate:self];
            break;
        }
        case YXNavigationAnimationStyle2Cube:{
            self.pushAnimation = [[YXPushVCCubeAnimation alloc] init];
            self.popAnimation = [[YXPopVCCubeAnimation alloc] init];
            break;
        }
        default:
            break;
    }
}

- (void)addPercentDriven:(UIViewController *)toVC {
    [self.popPercentDriven prepareGestureRecognizer:toVC];
}

- (void)removePercentDriven {
    [self.popPercentDriven removeGestureRecognizer];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush: {
            return self.pushAnimation;
        }
        case UINavigationControllerOperationPop: {
            return self.popAnimation;
        }
        default:
            break;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (animationController == self.popAnimation) {
        return self.popPercentDriven.interacting ? self.popPercentDriven : nil;
    } else {
        return nil;
    }
}

@end


@interface YXPushVCAnimation ()

@property (nonatomic, weak) YXNavigationControllerDelegate *controllerDelegate;

@end

@implementation YXPushVCAnimation

- (instancetype)initWithControllerDelegate:(YXNavigationControllerDelegate *)controllerDelegate {
    self = [super init];
    if (self) {
        self.controllerDelegate = controllerDelegate;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return .5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = [transitionContext containerView];
    UIView *fromVCView = fromVC.view;
    UIView *toVCView = toVC.view;
    
    CGRect frame = toVCView.frame;
    toVCView.frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    
    [transitionView addSubview:toVCView];
    
    [UIView animateWithDuration:.5 animations:^{
        fromVCView.transform = CGAffineTransformMakeScale(.8, .8);
        toVCView.frame = frame;
    } completion:^(BOOL finished){
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        } else {
            fromVCView.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:YES];
            
            [self.controllerDelegate addPercentDriven:toVC];
        }
    }];
}

@end


@interface YXPopVCAnimation ()

@property (nonatomic, weak) YXNavigationControllerDelegate *controllerDelegate;

@end

@implementation YXPopVCAnimation

- (instancetype)initWithControllerDelegate:(YXNavigationControllerDelegate *)controllerDelegate {
    self = [super init];
    if (self) {
        self.controllerDelegate = controllerDelegate;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return .5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *transitionView = [transitionContext containerView];
    UIView *toVCView = toVC.view;
    UIView *fromVCView = fromVC.view;
    
    [transitionView insertSubview:toVCView belowSubview:fromVCView];
    
    toVCView.transform = CGAffineTransformMakeScale(.8, .8);
    
    CGRect frame = fromVCView.frame;
    frame.origin.x += frame.size.width;
    
    [UIView animateWithDuration:.5 animations:^{
        fromVCView.frame = frame;
        toVCView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        if ([transitionContext transitionWasCancelled]) {
            toVCView.transform = CGAffineTransformIdentity;
            [toVCView removeFromSuperview];
            [transitionContext completeTransition:NO];
        } else {
            [transitionContext completeTransition:YES];
            
            [self.controllerDelegate removePercentDriven];
        }
    }];
}

@end


@interface YXPercentDrivenPopAnimation ()

@property (nonatomic, weak) UIViewController *toVC;

@property (nonatomic, weak) UIPanGestureRecognizer *panG;

@property (nonatomic, assign) BOOL interacting;

@end

@implementation YXPercentDrivenPopAnimation

- (void)prepareGestureRecognizer:(UIViewController *)toVC {
    self.toVC = toVC;
    
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    [self.toVC.view addGestureRecognizer:panG];
    
    self.panG = panG;
}

- (void)removeGestureRecognizer {
    [self.toVC.view removeGestureRecognizer:self.panG];
    
    self.toVC = nil;
    self.panG = nil;
}

- (void)panHandle:(UIPanGestureRecognizer *)g {
    UIGestureRecognizerState state = g.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        CGPoint movePoint = [g translationInView:self.toVC.view];
        if (self.toVC.navigationController.viewControllers.count > 1 && movePoint.x > 0) {
            [self.toVC.navigationController popViewControllerAnimated:YES];
        }
    } else if (state == UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [g translationInView:self.toVC.view];
        if (movePoint.x <= 0) {
            [self updateInteractiveTransition:0];
        } else {
            [self updateInteractiveTransition:movePoint.x/self.toVC.view.frame.size.width];
        }
    } else if (state == UIGestureRecognizerStateEnded) {
        self.interacting = NO;
        CGPoint movePoint = [g translationInView:self.toVC.view];
        if (movePoint.x <= 0) {
            [self cancelInteractiveTransition];
        } else {
            if (movePoint.x/self.toVC.view.frame.size.width > .4) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
    } else if (state == UIGestureRecognizerStateCancelled) {
        self.interacting = NO;
        [self cancelInteractiveTransition];
    }
}

@end
