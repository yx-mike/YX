//
//  YXCollectionViewDragLayout.h
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXCollectionViewDragLayout : UICollectionViewFlowLayout

- (void)startDraggingIndexPath:(NSIndexPath *)indexPath fromPoint:(CGPoint)p;
- (void)updateDragLocation:(CGPoint)point;
- (void)stopDragging;

@end
