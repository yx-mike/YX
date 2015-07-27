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

@property (strong, nonatomic) NSArray *ios7Titles;
@property (strong, nonatomic) NSArray *ios7VCNames;

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
        
        _ios7Titles = @[@"第4章 故事板"];
        _ios7VCNames = @[@""];
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
    NSArray *titles;
    switch (indexPath.section) {
        case 0: titles = self.titles;break;
        case 1: titles = self.ios7Titles;break;
        default: titles = @[];break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell bindValuesForTitle:titles[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: return @"第6版";
        case 1: return @"第7版";
        default: return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return self.titles.count;
        case 1: return self.ios7Titles.count;
        default: return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *vcNames;
    switch (indexPath.section) {
        case 0: vcNames = self.vcNames;break;
        case 1: vcNames = self.ios7VCNames;break;
        default: vcNames = @[];break;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CustomVCStoryboard" bundle:[NSBundle mainBundle]];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        #warning 用NSString生成Class
        Class vcClass = NSClassFromString(vcNames[indexPath.row]);
        [self.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
    }
}

@end
