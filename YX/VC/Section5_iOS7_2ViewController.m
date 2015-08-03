//
//  Section5_iOS7_2ViewController.m
//  YX
//
//  Created by 杨鑫 on 15/7/29.
//  Copyright (c) 2015年 ShanghaiCize Trade And Business Co., Ltd. All rights reserved.
//

#import "Section5_iOS7_2ViewController.h"
//
#import "YXPhotoCollectionViewCell.h"
//
#import "YXCoverFlowLayout.h"
//
#import "NSLayoutConstraint+YXCommon.h"
//
#import "Macros.h"

@interface Section5_iOS7_2ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSArray *photosList;
@property (strong, nonatomic) NSCache *photosCache;
@property (weak, nonatomic) UICollectionView *collectionView;

@end

static NSString *CellIdentifier = @"YXPhotoCollectionViewCell";

@implementation Section5_iOS7_2ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photosList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self photosDirectory] error:nil];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    //
    self.view.backgroundColor = [UIColor lightGrayColor];
    //
    YXCoverFlowLayout *coverFlowLayout = [[YXCoverFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:coverFlowLayout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:collectionView];
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint view:collectionView width:FullScreenWidth height:FullScreenHeight/2.0];
    [NSLayoutConstraint viewCenterSuperView:collectionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
    self.title = @"CoverFlowLayout";
    //
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[YXPhotoCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photosList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YXPhotoCollectionViewCell *cell = (YXPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *photoName = self.photosList[indexPath.row];
    NSString *photoFilePath = [[self photosDirectory] stringByAppendingPathComponent:photoName];
    
    __block UIImage* thumbImage = [self.photosCache objectForKey:photoName];
    cell.imageView.image = thumbImage;
    
    YXCoverFlowLayout *layout = (YXCoverFlowLayout *)collectionView.collectionViewLayout;
    if(!thumbImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];
            float scale = [UIScreen mainScreen].scale;
            
            UIGraphicsBeginImageContextWithOptions(layout.itemSize, YES, scale);
            [image drawInRect:CGRectMake(0, 0, layout.itemSize.width, layout.itemSize.height)];
            thumbImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.photosCache setObject:thumbImage forKey:photoName];
                cell.imageView.image = thumbImage;
            });
        });
    }
    
    return cell;
}

#pragma mark - Directory

- (NSString*)photosDirectory
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Photos"];
}

@end
