//
//  Section13_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/21.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section13_2ViewController.h"
//
#import "Macros.h"
#import "Constant.h"

@interface Section13_2ViewController ()

@property (weak, nonatomic) UILabel *label;
@property (nonatomic) NSUInteger count;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic) BOOL shouldRun;

- (void)addNextOperation;

@end

@implementation Section13_2ViewController
{
    NSUInteger _count;
}

- (void)loadView
{
    [super loadView];
    //
    self.title = @"简单的GCD";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FullScreenWidth, FullScreenHeight-NavigationHeight)];
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
    self.queue = dispatch_queue_create("com.yx.SimpleGCD.ViewController", DISPATCH_QUEUE_CONCURRENT);
    self.count = 0;
    [self addNextOperation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //
    dispatch_suspend(self.queue);
}

- (NSUInteger)count {
    __block NSUInteger count;
    dispatch_sync(self.queue, ^{
        count = _count;
    });
    return count;
}

- (void)setCount:(NSUInteger)count {
    dispatch_barrier_async(self.queue, ^{
        _count = count;
    });
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = [NSString stringWithFormat:@"%lu", (unsigned long)count];
    });
}

- (void)addNextOperation {
    __weak typeof(self) myself = self;
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, self.queue, ^(void){
        myself.count = myself.count + 1;
        [self addNextOperation];
    });
    #warning dispatch_after
}

@end
