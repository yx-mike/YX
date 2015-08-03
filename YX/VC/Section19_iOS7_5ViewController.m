//
//  Section19_iOS7_5ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/8/3.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section19_iOS7_5ViewController.h"
//
#import "YXCollectionViewDragLayout.h"
//
#import "Macros.h"

@interface Section19_iOS7_5ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGFloat columns;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic) NSUInteger remainderWidth;

@property (weak, nonatomic) UICollectionViewCell *longPressCell;

@end

static NSString *reuseIdent = @"UICollectionViewCell";

@implementation Section19_iOS7_5ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _columns = 4.0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"例子2";
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdent];
    
    //显示5列
    CGFloat width = FullScreenWidth*ScreenScale-self.columns+1.0;
    CGFloat cellWidth = floor(width/self.columns);
    CGFloat remainderWidth = fmod(width, self.columns);
    
    self.cellWidth = cellWidth/ScreenScale;
    self.remainderWidth = remainderWidth;
    
    UILongPressGestureRecognizer *longPressg = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
    [self.collectionView addGestureRecognizer:longPressg];
}

- (void)longPressHandle:(UILongPressGestureRecognizer *)g
{
    YXCollectionViewDragLayout *dragLayout = (YXCollectionViewDragLayout *)self.collectionView.collectionViewLayout;
    CGPoint location = [g locationInView:self.collectionView];
    
    UIGestureRecognizerState state = g.state;
    if (state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        
        self.longPressCell = cell;
        
        // Change the color and start dragging
        [UIView animateWithDuration:0.25 animations:^{
            self.longPressCell.backgroundColor = [UIColor redColor];
        }];
        [dragLayout startDraggingIndexPath:indexPath fromPoint:location];
    } else if (state == UIGestureRecognizerStateEnded) {
        // Change the color and stop dragging
        [UIView animateWithDuration:0.25 animations:^{
            self.longPressCell.backgroundColor = [UIColor whiteColor];
        }];
        [dragLayout stopDragging];
    } else {
        // Drag
        [dragLayout updateDragLocation:location];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdent forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger column = indexPath.row%((NSUInteger)self.columns);
    if (column < self.remainderWidth) {
        return CGSizeMake(self.cellWidth+OnePX, self.cellWidth);
    }
    return CGSizeMake(self.cellWidth, self.cellWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return OnePX;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return OnePX;
}

@end
