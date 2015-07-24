//
//  MainViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/12.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "MainViewController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"

@interface MainViewController ()

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *vcNames;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";

@implementation MainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titles = @[@"第6章 多个表视图", @"第8章 绘图功能", @"第9章 Core Animation", @"第13章 多线程", @"第14章 REST"];
        _vcNames = @[@"YXMutliTableViewController", @"SectionListNO8ViewController", @"SectionListNO9ViewController",
                     @"SectionListNO13ViewController", @"SectionListNO14ViewController"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.title = @"杨鑫";
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[YXNoMarginTableViewCell class] forCellReuseIdentifier:cellId];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell bindValuesForTitle:self.titles[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    #warning 用NSString生成Class
    NSString *vcClassName = self.vcNames[indexPath.row];
    Class vcClass = NSClassFromString(vcClassName);
    id vcObject = [[vcClass alloc] init];
    
    [self.navigationController pushViewController:vcObject animated:YES];
}

@end
