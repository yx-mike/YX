//
//  SectionListNO8ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/19.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "SectionListNO8ViewController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"

@interface SectionListNO8ViewController ()

@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSArray *vcNames;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";

@implementation SectionListNO8ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sections = @[@"1.Paths", @"2.Transform", @"3.Graph", @"4.Drawing",
                      @"5.像素对齐", @"6.CGLayer"];
        _vcNames = @[@"Section8_1ViewController", @"Section8_2ViewController", @"Section8_3ViewController", @"Section8_4ViewController",
                     @"Section8_5ViewController", @"Section8_6ViewController"];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //
    self.title = @"绘图";
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
