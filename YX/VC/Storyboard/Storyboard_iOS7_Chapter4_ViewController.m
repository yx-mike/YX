//
//  Storyboard_iOS7_Chapter4_ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/27.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Storyboard_iOS7_Chapter4_ViewController.h"
//
#import "CustomSegue.h"
#import "CustomUnwindSegue.h"

@interface Storyboard_iOS7_Chapter4_ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *customButton;

@end

@implementation Storyboard_iOS7_Chapter4_ViewController

#pragma mark - Public

- (UIView *)unWindView
{
    return self.customButton;
}

#pragma mark - Target Action

- (IBAction)doCustomPush:(id)sender
{
    [self performSegueWithIdentifier:@"CustomPush" sender:self];
}

- (IBAction)doDefaultPush:(id)sender
{
    [self performSegueWithIdentifier:@"DefaultPush" sender:self];
    
    // 使用Core Animation创建动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.7;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromRight;
    // 动画开始
    [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
}

- (IBAction)unwindFromViewController:(UIStoryboardSegue *)sender
{
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *vc = segue.destinationViewController;
    if ([segue.identifier isEqual:@"CustomPush"]) {
        vc.title = @"CustomPush";
        ((CustomSegue *)segue).fromView = self.customButton;
    } else if ([segue.identifier isEqual:@"DefaultPush"]) {
        vc.title = @"DefaultPush";
    }
}

@end
