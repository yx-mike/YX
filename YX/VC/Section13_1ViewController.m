//
//  Section13_1ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/21.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section13_1ViewController.h"
//
#import "Macros.h"
#import "Constant.h"

@interface Section13_1ViewController ()

@property (weak, nonatomic) UILabel *label;
@property (nonatomic) NSUInteger count;
@property (strong, nonatomic) NSOperationQueue *queue;

- (void)addNextOperation;

@end

@implementation Section13_1ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"简单的NSOperation";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FullkScreenWidth, FullScreenHeight-NavigationHeight)];
    self.label = label;
    label.text = @"0";
    label.font = [UIFont systemFontOfSize:88];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.queue = [[NSOperationQueue alloc] init];
    self.count = 0;
    [self addNextOperation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.queue.suspended = YES;
    self.queue = nil;
}

- (void)addNextOperation
{
    #warning NSOperation有一个- (void)addDependency:(NSOperation *)operation值得注意一下
    __weak typeof(self) weakSelf = self;
    NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        [NSThread sleepForTimeInterval:1];
        weakSelf.count = weakSelf.count + 1;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            weakSelf.label.text = [NSString stringWithFormat:@"%lu", (unsigned long)weakSelf.count];
        }];
    }];
    op.completionBlock = ^{
        [weakSelf addNextOperation];
    };
    
    [self.queue addOperation:op];
}

@end
