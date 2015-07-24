//
//  YXMultiSubTableViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/18.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXMultiSubTableViewController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"

@interface YXMultiSubTableViewController ()

@property (nonatomic) CGRect frame;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";

@implementation YXMultiSubTableViewController

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //
    self.view.frame = self.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[YXNoMarginTableViewCell class] forCellReuseIdentifier:cellId];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell bindValuesForTitle:[NSString stringWithFormat:@"%@ %ld", self.title, (long)indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

@end
