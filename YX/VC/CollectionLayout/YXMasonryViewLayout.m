//
//  YXMasonryViewLayout.m
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "YXMasonryViewLayout.h"

@interface YXMasonryViewLayout ()

//列数
@property (nonatomic) NSUInteger numberOfColumns;
//每列的间隔
@property (nonatomic) CGFloat interItemSpacing;
//每一列的最新的Y值
@property (strong, nonatomic) NSMutableDictionary *lastYValueForColumn;
//每个cell的布局参数
@property (strong, nonatomic) NSMutableDictionary *layoutInfo;

@end

@implementation YXMasonryViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _numberOfColumns = 3;
        _interItemSpacing = 8;
        _lastYValueForColumn = [NSMutableDictionary dictionary];
        _layoutInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void) prepareLayout
{
    //每列的宽度
    CGFloat columnWidth = (self.collectionView.frame.size.width - _interItemSpacing * (_numberOfColumns + 1))/_numberOfColumns;
    
    NSUInteger currentColumn = 0;
    NSIndexPath *indexPath;
    NSInteger numSections = [self.collectionView numberOfSections];
    for(NSInteger section = 0; section < numSections; section++)
    {
        NSInteger numItems = [self.collectionView numberOfItemsInSection:section];
        for(NSInteger item = 0; item < numItems; item++)
        {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *itemAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            CGFloat x = self.interItemSpacing + (self.interItemSpacing + columnWidth) * currentColumn;
            CGFloat y = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
            
            CGFloat height = [((id<YXMasonryViewLayoutDelegate>)self.collectionView.delegate) collectionView:self.collectionView
                                                                                                      layout:self
                                                                                    heightForItemAtIndexPath:indexPath];
            
            itemAttributes.frame = CGRectMake(x, y, columnWidth, height);
            y += height;
            y += self.interItemSpacing;
            
            self.lastYValueForColumn[@(currentColumn)] = @(y);
            
            currentColumn++;
            if(currentColumn == self.numberOfColumns) currentColumn = 0;
            self.layoutInfo[indexPath] = itemAttributes;
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
        //检查cell的frame是否在rect内
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [allAttributes addObject:attributes];
        }
    }];
    return allAttributes;
}

//此方法是在collectionView视图更新时调用的
//http://stackoverflow.com/questions/18989069/uicollectionviewlayout-when-is-layoutattributesforitematindexpath-called
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[indexPath];
}

-(CGSize)collectionViewContentSize
{
    NSUInteger currentColumn = 0;
    CGFloat maxHeight = 0;
    do {
        CGFloat height = [self.lastYValueForColumn[@(currentColumn)] doubleValue];
        if(height > maxHeight)
            maxHeight = height;
        currentColumn ++;
    } while (currentColumn < self.numberOfColumns);
    
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight);
}

@end
