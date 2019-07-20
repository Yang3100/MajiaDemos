//
//  KJSimpleDrawVC.m
//  启蒙画板
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJSimpleDrawVC.h"
#import "KJShowcaseModel.h"
#import "KJWaterfall.h"
#import "KJShowcaseCell.h"

#define per_page_num 50

@interface KJSimpleDrawVC ()<CHTCollectionViewDelegateWaterfallLayout>
/// temps
@property (nonatomic,readwrite,strong) NSMutableArray *temps;

@end

@implementation KJSimpleDrawVC

/// 重写init方法，配置你想要的属性
- (instancetype)init{
    if (self=[super init]) {
        /// create collectionViewLayout
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        layout.minimumColumnSpacing = 20;
        layout.minimumInteritemSpacing = 20;
        layout.columnCount = 1; // 每行个数
        self.collectionViewLayout = layout;
        self.perPage = per_page_num;
        
        /// 支持上下拉加载和刷新
        self.shouldPullUpToLoadMore = YES;
        self.shouldPullDownToRefresh = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 设置
    [self _setup];
    
    /// 设置导航栏
    [self _setupNavigationItem];
    
    /// 设置子控件
    [self _setupSubViews];
    
    /// 布局子空间
    [self _makeSubViewsConstraints];
    
    /// 注册cell
    [self.collectionView registerClass:[KJShowcaseCell class]
            forCellWithReuseIdentifier:@"KJShowcaseCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//这里很关键，分两组，把banner放在第一组的footer，把分类按钮放在第二组的header
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"KJShowcaseCell" forIndexPath:indexPath];
}

- (void)configureCell:(KJShowcaseCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell configureModel:object Index:indexPath.row];
}

- (void)collectionViewDidTriggerHeaderRefresh{
    /// 下拉刷新事件 子类重写
    self.page = 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        /// 清掉数据源
        [self.dataSource removeAllObjects];
        [self.temps removeAllObjects];
        NSArray *imageName = [[KJShowcaseModel sharedInstance] getAllImages];
        int a = (int)imageName.count;
        CGFloat w = SCREEN_WIDTH-40;
        CGFloat h = w * 9 / 16;
        if (imageName.count<=per_page_num) {
            for (int i=0; i<a; i++) {
                KJWaterfall *wf8 = [[KJWaterfall alloc] init];
                wf8.imageUrl = imageName[i];
                // 获取图片的size
                //            CGSize size = [UIImage imageNamed:imageName[i]].size;
                wf8.width = w;
                wf8.height = h;
                [self.temps addObject:wf8];
            }
        }else{
            for (int i=0; i<per_page_num; i++) {
                KJWaterfall *wf8 = [[KJWaterfall alloc] init];
                wf8.imageUrl = imageName[i];
                wf8.width = w;
                wf8.height = h;
                [self.temps addObject:wf8];
            }
        }
        [self.dataSource addObjectsFromArray:self.temps];
        
        // 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self collectionViewDidFinishTriggerHeader:YES reload:YES];
    });
}

- (void)collectionViewDidTriggerFooterRefresh{
    /// 上拉加载事件 子类重写
    self.page = self.page + 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// 模拟数据
//        NSArray *imageName = [[KJShowcaseModel sharedInstance] getAllImages];
//        NSInteger count = imageName.count;
        /// 假设第3页的时候请求回来的数据 < self.perPage 模拟网络加载数据不够的情况
//        NSInteger hang = count/10;
//        for (NSInteger i = 0; i<hang; i++) {
//            if (i==hang-1) { // 最后一成
//                for (NSInteger j = 0; j<count%10; j++) {
//                    KJWaterfall *wf8 = [[KJWaterfall alloc] init];
//                    wf8.imageUrl = imageName[i*10+j];
//                    wf8.width = SCREEN_WIDTH-20;
//                    wf8.height = SCREEN_WIDTH/2-20;
//                    [self.temps addObject:wf8];
//                }
//            }else{
//                for (NSInteger j = 0; j<10; j++) {
//                    KJWaterfall *wf8 = [[KJWaterfall alloc] init];
//                    wf8.imageUrl = imageName[i*10+j];
//                    wf8.width = SCREEN_WIDTH-20;
//                    wf8.height = SCREEN_WIDTH/2-20;
//                    [self.temps addObject:wf8];
//                }
//            }
//        }
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self collectionViewDidFinishTriggerHeader:NO reload:YES];
    });
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
/// 子类必须override
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    KJWaterfall *waterfall = self.dataSource[indexPath.item];
    return CGSizeMake(waterfall.width, waterfall.height);
}

#pragma mark - 初始化
- (void)_setup{
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTABBAR_HEIGHT);
    self.collectionView.theme_backgroundColor = @"block_bg";
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
    
}

#pragma mark - 布局子控件
- (void)_makeSubViewsConstraints{
    
}

- (NSMutableArray*)temps{
    if (!_temps) {
        _temps = [NSMutableArray array];
    }
    return _temps;
}

@end
