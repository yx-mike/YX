//
//  YXVCTransitioningDelegate.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXVCPresentDelegate.h"


@interface YXVCPresentDelegate ()

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> present;
@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> dismiss;

@property (strong, nonatomic) YXDismissPercentDrivenAnimation *dismissPercentDriven;

@end

@implementation YXVCPresentDelegate

- (instancetype)initWithRootVC:(UIViewController *)vc {
    self = [super init];
    if (self) {
        _present = [[YXPresentVCAnimation alloc] initWithDelegate:self];
        _dismiss = [[YXDismissVCAnimation alloc] initWithDelegate:self];
        
        _dismissPercentDriven = [[YXDismissPercentDrivenAnimation alloc] initWithRootVC:vc];
    }
    return self;
}

- (void)addPercentDriven {
    [self.dismissPercentDriven prepareGestureRecognizer];
}

- (void)removePercentDriven {
    [self.dismissPercentDriven removeGestureRecognizer];
}

#pragma mark <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self.present;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismiss;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.dismissPercentDriven.interacting ? self.dismissPercentDriven : nil;
}

@end


@interface YXPresentVCAnimation ()

@property (nonatomic, weak) YXVCPresentDelegate *presentDelegate;

@end

@implementation YXPresentVCAnimation

- (instancetype)initWithDelegate:(YXVCPresentDelegate *)presentDelegate {
    self = [super init];
    if (self) {
        self.presentDelegate = presentDelegate;
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
    toVCView.frame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, frame.size.height);
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
            
            [self.presentDelegate addPercentDriven];
        }
    }];
}

@end


@interface YXDismissVCAnimation ()

@property (nonatomic, weak) YXVCPresentDelegate *presentDelegate;

@end

@implementation YXDismissVCAnimation

- (instancetype)initWithDelegate:(YXVCPresentDelegate *)presentDelegate {
    self = [super init];
    if (self) {
        self.presentDelegate = presentDelegate;
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
    frame.origin.y += frame.size.height;
    
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
            
            [self.presentDelegate removePercentDriven];
        }
    }];
}

@end


@interface YXDismissPercentDrivenAnimation ()

@property (nonatomic, strong) UIViewController *presentedVC;

@property (nonatomic, weak) UIPanGestureRecognizer *panG;

@property (nonatomic, assign) BOOL interacting;

@end

@implementation YXDismissPercentDrivenAnimation

- (instancetype)initWithRootVC:(UIViewController *)vc {
    self = [super init];
    if (self) {
        self.presentedVC = vc;
    }
    return self;
}

- (void)prepareGestureRecognizer {
    UIPanGestureRecognizer *panG = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    self.panG = panG;
    
    [self.presentedVC.view addGestureRecognizer:panG];
}

- (void)removeGestureRecognizer {
    [self.presentedVC.view removeGestureRecognizer:self.panG];
}

- (void)panHandle:(UIPanGestureRecognizer *)g {
    UIGestureRecognizerState state = g.state;
    if (state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        CGPoint movePoint = [g translationInView:self.presentedVC.view];
        if (movePoint.y > 0) {
            [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (state == UIGestureRecognizerStateChanged) {
        CGPoint movePoint = [g translationInView:self.presentedVC.view];
        if (movePoint.y <= 0) {
            [self updateInteractiveTransition:0];
        } else {
            [self updateInteractiveTransition:movePoint.y/self.presentedVC.view.frame.size.height];
        }
    } else if (state == UIGestureRecognizerStateEnded) {
        self.interacting = NO;
        CGPoint movePoint = [g translationInView:self.presentedVC.view];
        if (movePoint.y <= 0) {
            [self cancelInteractiveTransition];
        } else {
            if (movePoint.y/self.presentedVC.view.frame.size.height > .4) {
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
