//
//  SectionListiOS7NO20ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/4.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "SectionListiOS7NO20ViewController.h"
#import "YXNavigationController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"
//
#import "YXVCTransitioningDelegate.h"

@interface SectionListiOS7NO20ViewController ()

@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSArray *vcNames;

@property (strong, nonatomic) YXVCTransitioningDelegate *transitioningDelegate;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";

@implementation SectionListiOS7NO20ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sections = @[@"1.集合VC2集合VC", @"2.普通VC"];
        _vcNames = @[@"Section20_iOS7_1ViewController", @"Section20_iOS7_2ViewController"];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //
    self.title = @"自定义控制器过渡";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[YXNoMarginTableViewCell class] forCellReuseIdentifier:cellId];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell bindValuesForTitle:self.sections[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcClassName = self.vcNames[indexPath.row];
    Class vcClass = NSClassFromString(vcClassName);
    UIViewController *vcObject = [[vcClass alloc] init];
    
    if (indexPath.row == 1) {
        self.transitioningDelegate = [[YXVCTransitioningDelegate alloc] init];
        
        YXNavigationController *navC = [[YXNavigationController alloc] initWithRootViewController:vcObject];
        navC.transitioningDelegate = self.transitioningDelegate;
        [self presentViewController:navC animated:YES completion:nil];
    } else {
        [self.navigationController pushViewController:vcObject animated:YES];
    }
}

@end
