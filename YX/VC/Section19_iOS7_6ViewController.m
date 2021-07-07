//
//  Section19_iOS7_6ViewController.m
//  YX
//
//  Created by 杨鑫 on 2021/7/6.
//  Copyright © 2021 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_6ViewController.h"

#import "YXMotionDynamicMaker.h"
#import "YXMotionDynamicItem.h"


@interface Section19_iOS7_6ViewController ()

@property (nonatomic, strong) YXMotionDynamicMaker *motionDynamicMaker;

@end

@implementation Section19_iOS7_6ViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [YXMotionDynamicItem prepareImageSizeMap:@{} imageBezierMap:@{}];
    
    self.motionDynamicMaker = [[YXMotionDynamicMaker alloc] initWithView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

@end
