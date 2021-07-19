//
//  Section20_iOS7_4ViewController.m
//  YX
//
//  Created by 杨鑫 on 2021/7/18.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section20_iOS7_4ViewController.h"


@interface Section20_iOS7_4ViewController ()

@end

@implementation Section20_iOS7_4ViewController

- (void)loadView {
    [super loadView];
    //
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeButton.frame = CGRectMake(12, 34, 60, 44);
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Action

- (void)closePage:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
