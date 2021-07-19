//
//  YXNavigationControllerDelegate.m
//  YX
//
//  Created by 杨鑫 on 15/8/5.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXNavigationControllerDelegate.h"


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

- (void)setAnimationStyle:(YXNavigationAnimationStyle)animationStyle {
    _animationStyle = animationStyle;
    
    switch (animationStyle) {
        case YXNavigationAnimationStyle1: {
            self.pushAnimation = [[YXPushVCAnimation alloc] initWithControllerDelegate:self];
            self.popAnimation = [[YXPopVCAnimation alloc] initWithControllerDelegate:self];
            break;
        }
        case YXNavigationAnimationStyle2Cube: {
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
    if (self.animationStyle == YXNavigationAnimationStyle2Cube) {
        return nil;
    }
    
    if (animationController == self.popAnimation) {
        return self.popPercentDriven.interacting ? self.popPercentDriven : nil;
    } else {
        return nil;
    }
}

@end


#pragma mark - Push

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


#pragma mark - Cube

@interface YXPushVCCubeAnimation ()<CAAnimationDelegate>

@property (strong, nonatomic) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation YXPushVCCubeAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return .7f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView addSubview:toViewController.view];
    
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    animation.duration = 0.7;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    [containerView.layer addAnimation:animation forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
}

@end

@interface YXPopVCCubeAnimation ()<CAAnimationDelegate>

@property (strong, nonatomic) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation YXPopVCCubeAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return .7f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromLeft;
    animation.duration = 0.7;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    
    [containerView.layer addAnimation:animation forKey:nil];
    [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
}

@end


#pragma mark - 手势

@interface YXPercentDrivenPopAnimation ()

@property (nonatomic, weak) UIViewController *toVC;

@property (nonatomic, weak) UIPanGestureRecognizer *panG;
@property (nonatomic, weak) UIScreenEdgePanGestureRecognizer *edgePan;

@property (nonatomic, assign) BOOL interacting;

@end

@implementation YXPercentDrivenPopAnimation

- (void)prepareGestureRecognizer:(UIViewController *)toVC {
    self.toVC = toVC;
    
    // 普通的拖动
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    self.panG = panG;
    [self.toVC.view addGestureRecognizer:panG];
    
    // 边缘拖动
//    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
//    self.edgePan = edgePan;
//    edgePan.edges = UIRectEdgeLeft;
//    [self.toVC.view addGestureRecognizer:edgePan];
}

- (void)removeGestureRecognizer {
    if (self.panG) {
        [self.toVC.view removeGestureRecognizer:self.panG];
        
        self.panG = nil;
    }
    
    if (self.edgePan) {
        [self.toVC.view removeGestureRecognizer:self.edgePan];
        
        self.edgePan = nil;
    }
    
    self.toVC = nil;
}

- (void)panHandle:(UIPanGestureRecognizer *)g {
    UIView *view = self.toVC.view;
    UINavigationController *naVC = self.toVC.navigationController;
    
    UIGestureRecognizerState state = g.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        
        CGPoint movePoint = [g translationInView:view];
        if (naVC.viewControllers.count > 1 && movePoint.x >= 0) {
            [naVC popViewControllerAnimated:YES];
        }
    } else if (state == UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [g translationInView:view];
        if (movePoint.x <= 0) {
            [self updateInteractiveTransition:0];
        } else {
            [self updateInteractiveTransition:movePoint.x / view.frame.size.width];
        }
    } else if (state == UIGestureRecognizerStateEnded) {
        self.interacting = NO;
        
        CGPoint movePoint = [g translationInView:view];
        if (movePoint.x <= 0) {
            [self cancelInteractiveTransition];
        } else {
            if (movePoint.x / view.frame.size.width > .45) {
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

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)g {
    UIView *view = self.toVC.view;
    UINavigationController *naVC = self.toVC.navigationController;
    
    UIGestureRecognizerState state = g.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        
        if (naVC.viewControllers.count > 1) {
            [naVC popViewControllerAnimated:YES];
        }
    } else if (state == UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [g translationInView:view];
        if (movePoint.x <= 0) {
            [self updateInteractiveTransition:0];
        } else {
            [self updateInteractiveTransition:movePoint.x / view.frame.size.width];
        }
    } else if (state == UIGestureRecognizerStateEnded) {
        self.interacting = NO;
        
        CGPoint movePoint = [g translationInView:view];
        if (movePoint.x <= 0) {
            [self cancelInteractiveTransition];
        } else {
            if (movePoint.x / view.frame.size.width > .45) {
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
