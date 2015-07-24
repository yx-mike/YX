//
//  NoteMacros.h
//  YX
//
//  Created by 杨鑫 on 15/7/13.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#ifndef YX_NoteMacros_h
#define YX_NoteMacros_h


#endif

#ifdef DEBUG

#define Log(xx, ...) NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#else

#define Log(xx, ...)

#endif

//// 转成字符串
//#define STRINGIFY(S) #S
//// 需要解两次才解开的宏
//#define DEFER_STRINGIFY(S) STRINGIFY(S)
//#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
//// 为warning增加更多信息
//#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
//// 使宏前面可以加@
//#define KEYWORDIFY try {} @catch (...) {}
//
//// 最终使用的宏
//#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))