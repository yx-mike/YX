//
//  SectionListiOS7NO23ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/30.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "SectionListiOS7NO23ViewController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"

@interface SectionListiOS7NO23ViewController ()

@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSArray *vcNames;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";

@implementation SectionListiOS7NO23ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sections = @[@"1.信号量", @"2.分派源", @"3.分派I/O"];
        _vcNames = @[@"Section23_iOS7_1ViewController", @"Section23_iOS7_2ViewController", @"Section23_iOS7_3ViewController"];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //
    self.title = @"GCD";
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
    id vcObject = [[vcClass alloc] init];
    
    [self.navigationController pushViewController:vcObject animated:YES];
}

@end
