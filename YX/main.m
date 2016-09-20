//
//  main.m
//  YX
//
//  Created by 杨鑫 on 15/7/11.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface Father : NSObject {
    int _father;
}
@end
@implementation Father
@end

@interface Child : Father {
    int _child;
}
@end
@implementation Child
@end

int main(int argc, char * argv[]) {
    Child *child = [[Child alloc] init];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
