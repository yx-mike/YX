//
//  Section13_3ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/22.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section13_3ViewController.h"

@interface Section13_3ViewController ()

@end

@implementation Section13_3ViewController

- (void)loadView
{
    [super loadView];
    //
    self.title = @"GCD测试";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //打印主线程
    NSLog(@"打印主线程--%@", [NSThread mainThread]);
    //1.获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    //2.把任务添加到主队列中执行
    dispatch_async(queue, ^{
        NSLog(@"使用异步函数执行主队列中的任务1--%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"使用异步函数执行主队列中的任务2--%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"使用异步函数执行主队列中的任务3--%@",[NSThread currentThread]);
    });
    
    //3.用同步执行主队列, 会直接死锁
    //http://www.cnblogs.com/tangbinblog/p/4133481.html
    /*
    dispatch_sync(queue, ^{
        NSLog(@"使用同步函数执行主队列中的任务4--%@",[NSThread currentThread]);
    });
     */
    
    //这样可以的
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"使用异步函数执行主队列中的任务4--%@",[NSThread currentThread]);
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"使用异步函数执行主队列中的任务5--%@",[NSThread currentThread]);
        });
        NSLog(@"使用异步函数执行主队列中的任务6--%@",[NSThread currentThread]);
    });
}

//同步:dispatch_sync, dispatch_barrier_sync
//异步:dispatch_async, dispatch_barrier_async, dispatch_group_async

//队列:dispatch_queue_t
//并行:
//串行:

@end
