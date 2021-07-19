//
//  WDClimbPresentAnimationDelegate.m
//  YX
//
//  Created by 杨鑫 on 2021/7/19.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "WDClimbPresentAnimationDelegate.h"


@interface WDClimbPresentAnimationDelegate ()

@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> present;
@property (strong, nonatomic) id<UIViewControllerAnimatedTransitioning> dismiss;

@property (strong, nonatomic) WDClimbDismissPercentDrivenAnimation *dismissPercentDriven;

@end

@implementation WDClimbPresentAnimationDelegate

- (instancetype)initWithRootVC:(UIViewController *)vc {
    self = [super init];
    if (self) {
        _present = [[WDClimbPresentAnimation alloc] initWithDelegate:self];
        _dismiss = [[WDClimbDismissAnimation alloc] initWithDelegate:self];
        
        _dismissPercentDriven = [[WDClimbDismissPercentDrivenAnimation alloc] initWithRootVC:vc];
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


@interface WDClimbPresentAnimation ()

@property (nonatomic, weak) WDClimbPresentAnimationDelegate *presentDelegate;

@end

@implementation WDClimbPresentAnimation

- (instancetype)initWithDelegate:(WDClimbPresentAnimationDelegate *)presentDelegate {
    self = [super init];
    if (self) {
        self.presentDelegate = presentDelegate;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    CGRect startRect4To = toView.frame;
    CGRect endRect4To = toView.frame;
    CGRect startRect4From = fromView.frame;
    CGRect endRect4ToFrom = fromView.frame;
    
    startRect4To.origin.y -= startRect4To.size.height;
    endRect4ToFrom.origin.y += endRect4ToFrom.size.height;
    
    toView.frame = startRect4To;
    
    [[transitionContext containerView] addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        toView.frame = endRect4To;
        fromView.frame = endRect4ToFrom;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            [transitionContext completeTransition:NO];
        } else {
            fromView.frame = startRect4From;
            
            [transitionContext completeTransition:YES];
            
            [self.presentDelegate addPercentDriven];
        }
    }];
}

@end


@interface WDClimbDismissAnimation ()

@property (nonatomic, weak) WDClimbPresentAnimationDelegate *presentDelegate;

@end

@implementation WDClimbDismissAnimation

- (instancetype)initWithDelegate:(WDClimbPresentAnimationDelegate *)presentDelegate {
    self = [super init];
    if (self) {
        self.presentDelegate = presentDelegate;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    CGRect startRect4To = toView.frame;
    CGRect endRect4To = toView.frame;
//    CGRect startRect4From = fromView.frame;
    CGRect endRect4ToFrom = fromView.frame;
    
    startRect4To.origin.y += startRect4To.size.height;
    endRect4ToFrom.origin.y -= endRect4ToFrom.size.height;
    
    toView.frame = startRect4To;
    
    [[transitionContext containerView] addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        toView.frame = endRect4To;
        fromView.frame = endRect4ToFrom;
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.frame = endRect4To;
            [toView removeFromSuperview];
            
            [transitionContext completeTransition:NO];
        } else {
            [transitionContext completeTransition:YES];
            
            [self.presentDelegate removePercentDriven];
        }
    }];
}

@end


@interface WDClimbDismissPercentDrivenAnimation ()

@property (nonatomic, strong) UIViewController *presentedVC;

@property (nonatomic, weak) UIPanGestureRecognizer *panG;

@property (nonatomic, assign) BOOL interacting;

@end

@implementation WDClimbDismissPercentDrivenAnimation

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
    if (self.panG) {
        [self.presentedVC.view removeGestureRecognizer:self.panG];
        
        self.panG = nil;
    }
}

- (void)panHandle:(UIPanGestureRecognizer *)g {
    UIView *view = self.presentedVC.view;
    
    UIGestureRecognizerState state = g.state;
    CGPoint movePoint = [g translationInView:view];
    if (state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        
        if (movePoint.y <= 0) {
            [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (state == UIGestureRecognizerStateChanged) {
        if (movePoint.y >= 0) {
            [self updateInteractiveTransition:0];
        } else {
            [self updateInteractiveTransition:(-movePoint.y) / view.frame.size.height];
        }
    } else if (state == UIGestureRecognizerStateEnded) {
        self.interacting = NO;
        
        if (movePoint.y >= 0) {
            [self cancelInteractiveTransition];
        } else {
            if ((-movePoint.y) / view.frame.size.height > .3) {
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
