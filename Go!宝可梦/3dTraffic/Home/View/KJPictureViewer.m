//
//  KJPictureViewer.m
//  AnimationDemo
//
//  Created by 杨科军 on 2016/10/23.
//  Copyright © 2016年 杨科军. All rights reserved.
//

#import "KJPictureViewer.h"
#import "KJPictureCollectionViewCell.h"

static const CGFloat sp = 5.0;
static const int num = 2;

@interface KJPictureViewer ()<UICollectionViewDataSource,KJPictureCollectionCellDelegate,UIScrollViewDelegate>{
    CGFloat pictureW,pictureHeight;
}

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation KJPictureViewer

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        pictureW = frame.size.width;
        pictureHeight = frame.size.height;
        [self addSubview:self.collectionView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.kj_imageArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJPictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KJPictureCollectionViewCell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.delegate = self;
    cell.imageView.image = [UIImage imageNamed:self.kj_imageArray[indexPath.item]];
    return cell;
}

#pragma mark - KJPictureCollectionCellDelegate
-(void)pictureCollection:(KJPictureCollectionViewCell *)pictureCollectionCell didGestureSelectedImage:(UIImage *)image andImageWorldRect:(CGRect)imageWorldRect{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pictureViewer:didGestureSelectedImage:andImageWorldRect:Index:)]) {
        [self.delegate pictureViewer:self didGestureSelectedImage:image andImageWorldRect:imageWorldRect Index:pictureCollectionCell.tag];
    }
}

- (void)pictureCollection:(KJPictureCollectionViewCell *)pictureCollectionCell lockScollViewWithOnWindow:(BOOL)isOnWindow{
    self.collectionView.scrollEnabled = !isOnWindow;
}

#pragma mark - lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake((pictureW - num*sp)/num, pictureHeight);
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.contentSize = CGSizeMake(flowLayout.itemSize.width+sp * self.kj_imageArray.count, pictureHeight);
        _collectionView.directionalLockEnabled = YES;
        [_collectionView registerClass:[KJPictureCollectionViewCell class] forCellWithReuseIdentifier:@"KJPictureCollectionViewCell"];
    }
    return _collectionView;
}

@end

