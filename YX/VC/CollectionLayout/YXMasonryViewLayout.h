//
//  YXMasonryViewLayout.h
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXMasonryViewLayout;

@protocol YXMasonryViewLayoutDelegate <NSObject>

@required
- (CGFloat)collectionView:(UICollectionView*)collectionView layout:(YXMasonryViewLayout *)layout heightForItemAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface YXMasonryViewLayout : UICollectionViewLayout

@property (weak, nonatomic) IBOutlet id<YXMasonryViewLayoutDelegate> delegate;

@end
