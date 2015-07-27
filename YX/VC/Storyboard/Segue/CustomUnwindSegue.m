//  Created by Phillipus on 20/09/2013.
//  Copyright (c) 2013 Dada Beatnik. All rights reserved.
//

#import "CustomUnwindSegue.h"
//
#import "Storyboard_iOS7_Chapter4_ViewController.h"

@implementation CustomUnwindSegue

- (void)perform
{
    UIViewController *fromVC = self.sourceViewController;
    UIViewController *toVC = self.destinationViewController;
    UINavigationController *containerVC = fromVC.navigationController;
    
    //不这样弄，第一句insertSubview无效，可能是UINavigationCOntroller的缘故
    [containerVC.view insertSubview:toVC.view belowSubview:containerVC.navigationBar];
    [containerVC.view insertSubview:fromVC.view belowSubview:containerVC.navigationBar];
    
    UIView *toView = [toVC performSelector:@selector(unWindView)];
    CGSize toViewSize = toView.frame.size;
    CGSize fromVCSize = fromVC.view.frame.size;
    CGFloat minScale = MIN(toViewSize.width/fromVCSize.width, toViewSize.height/fromVCSize.height);
    CGPoint toViewCenterInContainerVC = [toView convertPoint:CGPointMake(toViewSize.width/2, toViewSize.height/2) toView:containerVC.view];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromVC.view.transform = CGAffineTransformMakeScale(minScale, minScale);
                         fromVC.view.center = toViewCenterInContainerVC;
                     }
                     completion:^(BOOL finished){
                         [toVC.view removeFromSuperview];
                         [fromVC.view removeFromSuperview];
                         
                         [containerVC popViewControllerAnimated:NO];
                         [containerVC setNavigationBarHidden:NO animated:NO];
                     }];
    
    //没有UINavigationController可以这么用
    /*
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add view to super view temporarily
    [sourceViewController.view.superview insertSubview:destinationViewController.view atIndex:0];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Shrink!
                         sourceViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
                         sourceViewController.view.center = self.targetPoint;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         [sourceViewController dismissViewControllerAnimated:NO completion:NULL]; // dismiss VC
                     }];
     */
}

@end
