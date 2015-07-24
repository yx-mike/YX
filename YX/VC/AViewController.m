//
//  AViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/17.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "AViewController.h"
//
#import "Macros.h"

@interface AViewController ()

@property (weak, nonatomic) UIButton *button;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UISwitch *switchButton;

@end

@implementation AViewController

- (void)loadView
{
    [super loadView];
    
    // add imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageAndType(ImageName(@"j4"), @"jpeg")];
    self.imageView = imageView;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    // add Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button = button;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"Test" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    // add Switch
    UISwitch *switchButton = [[UISwitch alloc] init];
    self.switchButton = switchButton;
    switchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:switchButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeCenterX
                                                         multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view attribute:NSLayoutAttributeCenterY
                                                         multiplier:1 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button][imageView][switchButton]" options:NSLayoutFormatAlignAllCenterX
                                                                      metrics:nil views:NSDictionaryOfVariableBindings(imageView, button, switchButton)]];
}

@end
