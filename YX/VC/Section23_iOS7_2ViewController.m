//
//  Section23_iOS7_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/30.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section23_iOS7_2ViewController.h"

@interface Section23_iOS7_2ViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation Section23_iOS7_2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"分派源";
}

- (IBAction)startButtonTap:(id)sender
{
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD, 0, 0, dispatch_get_main_queue());
    
    __block long totalComplete = 0;
    dispatch_source_set_event_handler(source, ^{
        long value = dispatch_source_get_data(source);
        totalComplete += value;
        self.progressView.progress = (CGFloat)totalComplete/100.0f;
    });
    dispatch_resume(source);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i <= 100; ++i) {
            dispatch_source_merge_data(source, 1);
            usleep(20000);
        }
    });
}

@end
