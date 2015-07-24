//
//  SectionListNO9ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/20.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "SectionListNO9ViewController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"

@interface SectionListNO9ViewController ()

@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSArray *vcNames;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";

@implementation SectionListNO9ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sections = @[@"1.View Animation", @"2.CALayer", @"3.CALayerAnimation", @"4.CATransform3D",
                      @"5.美化图层", @"6.用动作实现自动动画"];
        _vcNames = @[@"Section9_1ViewController", @"Section9_2ViewController", @"Section9_3ViewController", @"Section9_4ViewController",
                     @"Section9_5ViewController", @"Section9_6ViewController"];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //
    self.title = @"动画";
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
