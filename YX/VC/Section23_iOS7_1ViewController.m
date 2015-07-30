//
//  Section23_iOS7_1ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/30.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section23_iOS7_1ViewController.h"
//
#import "RNQueue.h"

@interface Section23_iOS7_1ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *pendingQueueCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIProgressView) NSArray *progressViewArray;
@property (weak, nonatomic) IBOutlet UILabel *inQueueLabel;

//信号量
@property (nonatomic) dispatch_semaphore_t semaphore;
//串行队列
@property (nonatomic) dispatch_queue_t pendingQueue;
//并发队列
@property (nonatomic) dispatch_queue_t workQueue;
// Should only be accessed through adjustPendingJobCountBy:
@property (nonatomic) NSInteger pendingJobCount;

@end

@implementation Section23_iOS7_1ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pendingQueue = RNQueueCreateTagged("ProducerConsumer.pending", DISPATCH_QUEUE_SERIAL);
        _workQueue = RNQueueCreateTagged("ProducerConsumer.work", DISPATCH_QUEUE_CONCURRENT);
        _pendingJobCount = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.title = @"信号量";
    self.semaphore = dispatch_semaphore_create([self.progressViewArray count]);
}

- (IBAction)addBlockToQueue:(id)sender
{
    //判断是否是主线程，感觉在这里判断没什么必要
    RNAssertMainQueue();
    //+1
    [self adjustPendingJobCountBy:1];
    
    dispatch_async(self.pendingQueue, ^{
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        
        //选择空闲的进度条
        UIProgressView *availableProgressView = [self reserveProgressView];
        
        dispatch_async(self.workQueue, ^{
            // Perform the dummy work
            [self performWorkWithProgressView:availableProgressView];
            
            // Let go of our resource
            [self releaseProgressView:availableProgressView];
            
            // Update the UI
            [self adjustPendingJobCountBy:-1];
            
            // Release our slot so another job can start
            dispatch_semaphore_signal(self.semaphore);
        });
    });
}

- (void)adjustPendingJobCountBy:(NSInteger)value
{
    // Safe on any queue
    dispatch_async(dispatch_get_main_queue(), ^{
        self.pendingJobCount += value;
        self.inQueueLabel.text = [NSString stringWithFormat:@"%ld", (long)self.pendingJobCount];
    });
}

- (UIProgressView *)reserveProgressView
{
    RNAssertQueue(self.pendingQueue);
    
    __block UIProgressView *availableProgressView;
    dispatch_sync(dispatch_get_main_queue(), ^{
        for (UIProgressView *progressView in self.progressViewArray) {
            if (progressView.isHidden) {
                availableProgressView = progressView;
                break;
            }
        }
        availableProgressView.hidden = NO;
        availableProgressView.progress = 0;
    });
    
    NSAssert(availableProgressView, @"There should always be one available here.");
    return availableProgressView;
}

- (void)performWorkWithProgressView:(UIProgressView *)progressView
{
    RNAssertQueue(self.workQueue);
    
    for (NSUInteger p = 0; p <= 100; ++p) {
        //阻塞当前线程，等待进度完成
        dispatch_sync(dispatch_get_main_queue(), ^{
            progressView.progress = p/100.0;
        });
        usleep(50000);
    }
}

- (void)releaseProgressView:(UIProgressView *)progressView
{
    RNAssertQueue(self.workQueue);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        progressView.hidden = YES;
    });
}

@end
