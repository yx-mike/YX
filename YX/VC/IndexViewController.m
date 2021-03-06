//
//  MainViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/12.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "IndexViewController.h"
//
#import "UITableViewCell+YXSetValues.h"
#import "YXNoMarginTableViewCell.h"

@interface IndexViewController ()

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSArray *vcNames;

@property (strong, nonatomic) NSArray *ios7Titles;
@property (strong, nonatomic) NSArray *ios7VCNames;

@property (strong, nonatomic) NSArray *layerTitles;
@property (strong, nonatomic) NSArray *layerVCNames;

@end

static NSString * const cellId = @"YXNoMarginTableViewCell";

@implementation IndexViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _titles = @[@"第6章 多个表视图", @"第8章 绘图功能", @"第9章 Core Animation", @"第13章 多线程", @"第14章 REST"];
        _vcNames = @[@"YXMutliTableViewController", @"SectionListNO8ViewController", @"SectionListNO9ViewController", @"SectionListNO13ViewController", @"SectionListNO14ViewController"];
        
        _ios7Titles = @[@"第4章 故事板", @"第5章 集合视图", @"第19章 UIKit动力学", @"第20章 自定义控制器过渡", @"第23章 GCD"];
        _ios7VCNames = @[@"", @"SectionListiOS7NO5ViewController", @"SectionListiOS7NO19ViewController", @"SectionListiOS7NO20ViewController", @"SectionListiOS7NO23ViewController"];
        
        _layerTitles = @[@"CAGradientLayer&CAShapeLayer"];
        _layerVCNames = @[@"MultiColorCircleLayerVC"];
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
        case 2: titles = self.layerTitles;break;
        default: titles = @[];break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell bindValuesForTitle:titles[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: return @"第6版";
        case 1: return @"第7版";
        case 2: return @"Layer";
        default: return @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return self.titles.count;
        case 1: return self.ios7Titles.count;
        case 2: return self.layerTitles.count;
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
        case 2: vcNames = self.layerVCNames;break;
        default: vcNames = @[];break;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CustomVCStoryboard" bundle:[NSBundle mainBundle]];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        #warning 用NSString生成Class
        Class vcClass = NSClassFromString(vcNames[indexPath.row]);
        [self.navigationController pushViewController:[[vcClass alloc] init] animated:YES];
    }
}

@end
