//
//  Macros.h
//  WC
//
//  Created by 杨鑫 on 15/4/13.
//  Copyright (c) 2015年 智康. All rights reserved.
//

#define ImageName(name) [NSString stringWithFormat:@"%@@%dx", name, (int)[UIScreen mainScreen].scale]
#define ImageAndType(fileName, type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:type]]
#define Image(fileName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]]
#define ImageOriginal(name) [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define PrepContraints(View) [View setTranslatesAutoresizingMaskIntoConstraints:NO]

#define FullScreenHeight   ([UIScreen mainScreen].bounds.size.height)
#define FullkScreenWidth    ([UIScreen mainScreen].bounds.size.width)
#define FullScreenFrame    (CGRectMake(0,0,kScreenWidth,kScreenHeight))
#define OnePX (1.0/[UIScreen mainScreen].scale)

#define AppBackgroundColor HexRGB(0xf8f8f8)
#define TextColor HexRGB(0x5e606d)
#define BorderColor HexRGB(0xe2e2e2)

#ifdef DEBUG
#define Log(xx, ...) NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define Log(xx, ...)
#endif