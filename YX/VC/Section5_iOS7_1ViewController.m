//
//  Section5_iOS7_1ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section5_iOS7_1ViewController.h"
//
#import "YXMasonryViewLayout.h"

@interface Section5_iOS7_1ViewController ()<UICollectionViewDelegateFlowLayout, YXMasonryViewLayoutDelegate>

@end

static NSString *CellIdentifier = @"UICollectionViewCell";

@implementation Section5_iOS7_1ViewController

- (instancetype)init
{
    return [self initWithCollectionViewLayout:nil];
}

 - (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    YXMasonryViewLayout *viewLayout = [[YXMasonryViewLayout alloc] init];
    viewLayout.delegate = self;
    self = [super initWithCollectionViewLayout:viewLayout];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"瀑布流集合视图";
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomHeight = 100 + (arc4random() % 140);
    return CGSizeMake(100, randomHeight); // 100 to 240 pixels tall
}

#pragma mark - <YXMasonryViewLayoutDelegate>

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(YXMasonryViewLayout *)layout
  heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomHeight = 100 + (arc4random() % 140);
    return randomHeight;
}

@end
