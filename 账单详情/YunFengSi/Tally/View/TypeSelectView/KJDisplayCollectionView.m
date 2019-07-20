//
//  KJDisplayCollectionView.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJDisplayCollectionView.h"
#import "KJDisplayCollectionViewCell.h"

@interface KJDisplayCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSIndexPath  *selectPath;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation KJDisplayCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]){
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJDisplayCollectionViewCell *cell = (KJDisplayCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"KJDisplayCollectionViewCell" forIndexPath:indexPath];
    cell.cell_tag = indexPath.row;
    if (indexPath.row==0){
        cell.isCellSelect = YES;
        self.selectPath = indexPath;
    }else{
        cell.isCellSelect = NO;
    }
    return cell;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    !self.updateClicked?:self.updateClicked(indexPath.row);
    if (self.selectPath==nil){
        KJDisplayCollectionViewCell  *cell = (KJDisplayCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.isCellSelect = YES;
        self.selectPath = indexPath;
    }else{
        if (self.selectPath!=indexPath){
            KJDisplayCollectionViewCell  *oldCell = (KJDisplayCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:self.selectPath];
            oldCell.isCellSelect = NO;
            KJDisplayCollectionViewCell  *newCell = (KJDisplayCollectionViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
            newCell.isCellSelect = YES;
            self.selectPath = indexPath;
        }
    }
}
#pragma mark - getter
- (UICollectionView *)collectionView{
    if (!_collectionView){
        //1.初始化layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //该方法也可以设置itemSize
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/6, SCREEN_WIDTH/6/3);
        //2.初始化collectionView
        CGFloat h = (self.dataArray.count/3 + 1)* Handle(50)+ Handle(10);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, h)collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollEnabled = NO;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中一致
        [_collectionView registerClass:[KJDisplayCollectionViewCell class] forCellWithReuseIdentifier:@"KJDisplayCollectionViewCell"];
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray){
        _dataArray = [NSMutableArray array];
        for (NSInteger i=0; i<2; i++){
            [_dataArray addObject:@(i)];
        }
    }
    return _dataArray;
}

@end

