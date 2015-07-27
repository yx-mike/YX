//  Created by Phillipus on 19/09/2013.
//  Copyright (c) 2013 Dada Beatnik. All rights reserved.
//

#import "CustomSegue.h"

@implementation CustomSegue

- (void)perform
{
    UIViewController *fromVC = self.sourceViewController;
    UIViewController *toVC = self.destinationViewController;
    UINavigationController *containerVC = fromVC.navigationController;
    
    [containerVC.view insertSubview:toVC.view belowSubview:containerVC.navigationBar];
    [containerVC setNavigationBarHidden:YES animated:NO];
    
    CGSize fromViewSize = self.fromView.frame.size;
    CGSize toVCSize = toVC.view.frame.size;
    CGFloat minScale = MIN(fromViewSize.width/toVCSize.width, fromViewSize.height/toVCSize.height);
    toVC.view.transform = CGAffineTransformMakeScale(minScale, minScale);
    toVC.view.center = [self.fromView convertPoint:CGPointMake(fromViewSize.width/2, fromViewSize.height/2) toView:containerVC.view];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVC.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         toVC.view.center = fromVC.view.center;
                     }
                     completion:^(BOOL finished){
                         [fromVC.view removeFromSuperview];
                         [toVC.view removeFromSuperview];
                         [containerVC pushViewController:toVC animated:NO];
                     }];
    
    //没有UINavigationController可以这么用
    /*
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    // Add the destination view as a subview, temporarily
    [sourceViewController.view addSubview:destinationViewController.view];
    
    // Transformation start scale
    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
    
    // Store original centre point of the destination view
    CGPoint originalCenter = destinationViewController.view.center;
    // Set center to start point of the button
    destinationViewController.view.center = self.originatingPoint;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Grow!
                         destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         destinationViewController.view.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         [destinationViewController.view removeFromSuperview]; // remove from temp super view
                         [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
                     }];
     */
}

@end
