//
//  KJTypeView.m
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJTypeView.h"
#import "KJTypeViewCell.h"

@interface KJTypeView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSIndexPath  *selectPath;
@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation KJTypeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]){
        [self setUI];
    }
    return self;
}

- (instancetype)init{
    if (self=[super init]) {
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
    KJTypeViewCell *cell = (KJTypeViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"KJTypeViewCell" forIndexPath:indexPath];
    cell.name = self.dataArray[indexPath.row];
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
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectPath==nil){
        KJTypeViewCell  *cell = (KJTypeViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
        cell.isCellSelect = YES;
        self.selectPath = indexPath;
    }else{
        if (self.selectPath!=indexPath){
            KJTypeViewCell  *oldCell = (KJTypeViewCell*)[self.collectionView cellForItemAtIndexPath:self.selectPath];
            oldCell.isCellSelect = NO;
            KJTypeViewCell  *newCell = (KJTypeViewCell*)[self.collectionView cellForItemAtIndexPath:indexPath];
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
        CGFloat w = (self.frame.size.width - 60)/4;
        layout.itemSize = CGSizeMake(w,w);
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.scrollEnabled = YES;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中一致
        [_collectionView registerClass:[KJTypeViewCell class] forCellWithReuseIdentifier:@"KJTypeViewCell"];
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSArray *)dataArray{
    if (!_dataArray){
        _dataArray = @[@"餐饮",@"电子设备",@"旅游",@"话费",@"交通",@"娱乐",@"学习",@"住宿",@"娱乐",@"学习",@"住宿",@"其他"];
    }
    return _dataArray;
}

@end
