//
//  YXMacros.h
//  YX
//
//  Created by 杨鑫 on 15/7/13.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#warning Draw绘图时，进行像素点的一些处理;

enum LineDrection {
    kLineHorizontal,
    kLineVertical
};
typedef enum LineDrection LineDrection;

enum PointCorner {
    kPointLeftTop,
    kPointLeftBottom,
    kPointRightTop,
    kPointRightBottom
};
typedef enum PointCorner PointCorner;

CG_INLINE CGPoint
CGPointPathChange(CGPoint p, LineDrection drection, int d)
{
    CGFloat scale = [UIScreen mainScreen].scale;
    int scaleX = p.x*scale;
    int scaleY = p.y*scale;
    
    CGPoint change;
    if (drection == kLineHorizontal) {
        change.x = scaleX/scale;
        change.y = (scaleY+0.5*d)/scale;
    } else {
        change.x = (scaleX+0.5*d)/scale;
        change.y = scaleY/scale;
    }
    
    return change;
}