//
//  KJStadyVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/10/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJStadyVC.h"

#import "KJWaterfall.h"
#import "KJSimpleDrawCell.h"

#import "KJSetDrawVC.h"

@interface KJStadyVC ()<CHTCollectionViewDelegateWaterfallLayout>{
    NSMutableArray *imageName;
    __block NSMutableArray *imageColors;
}

/// temps
@property (nonatomic,readwrite,strong) NSMutableArray *temps;

@end

@implementation KJStadyVC

/// 重写init方法，配置你想要的属性
- (instancetype)init{
    if (self=[super init]) {
        /// create collectionViewLayout
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(Cell_Space, Cell_Space, Cell_Space, Cell_Space);
        layout.minimumColumnSpacing = Cell_Space;
        layout.minimumInteritemSpacing = Cell_Space;
        layout.columnCount = 2; // 每行个数
        self.collectionViewLayout = layout;
        self.perPage = 10;
        
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
    [self.collectionView registerClass:[KJSimpleDrawCell class]
            forCellWithReuseIdentifier:@"KJSimpleDrawCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//这里很关键，分两组，把banner放在第一组的footer，把分类按钮放在第二组的header
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"KJSimpleDrawCell" forIndexPath:indexPath];
}

- (void)configureCell:(KJSimpleDrawCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell configureModel:object];
}

- (void)collectionViewDidTriggerHeaderRefresh{
    /// 下拉刷新事件 子类重写
    self.page = 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        /// 清掉数据源
        [self.dataSource removeAllObjects];
        [self->imageColors removeAllObjects];
        for (int i = 0; i<10; i++) {
            [self.dataSource addObject:self.temps[i]];
            [self analysisImageColors:i];
        }
        
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
        /// 假设第3页的时候请求回来的数据 < self.perPage 模拟网络加载数据不够的情况
        NSInteger count = self.temps.count;

        if (self.page==1) {
            for (int i = 0; i<10; i++) {
                [self.dataSource addObject:self.temps[i]];
                [self analysisImageColors:i];
            }
        }
        if (self.page==2){
            for (int i = 10; i<20; i++) {
                [self.dataSource addObject:self.temps[i]];
                [self analysisImageColors:i];
            }
        }
        if (self.page==3){
            for (int i = 20; i<count; i++) {
                [self.dataSource addObject:self.temps[i]];
                [self analysisImageColors:i];
            }
        }
        
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self collectionViewDidFinishTriggerHeader:NO reload:YES];
    });
}

- (void)analysisImageColors:(int)index{
//    dispatch_queue_t queue = dispatch_queue_create("com.yangkejun.GCDdemo", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        KJWaterfall *model = self.temps[index];
//        UIImage *lastImage = GetImage(model.imageUrl);
//        NSArray *colors = [lastImage kj_getColorsFromImage:lastImage count:9];
//        [self->imageColors addObjectsFromArray:colors];
//    });
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    UIImage *lastImage = GetImage(imageName[indexPath.row]);
    KJSetDrawVC *vc = [[KJSetDrawVC alloc] initWithOldImage:GetImage(imageName[indexPath.row])];
    // 先判断颜色数组是否完成
//    if (imageColors.count>indexPath.row) {
//        vc.imageColors = imageColors[indexPath.row];
//    }else{
//    }
    vc.imageColors = [lastImage kj_getColorsFromImage:lastImage count:9];
    [self.navigationController pushViewController:vc animated:YES];
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
        imageName = [NSMutableArray array];
        imageColors = [NSMutableArray array];
        for (int i = 1; i<=21; i++) {
            [imageName addObject:[NSString stringWithFormat:@"sucai_%d",i]];
        }
        int a = (int)imageName.count;
        for (int i=0; i<a; i++) {
            KJWaterfall *wf8 = [[KJWaterfall alloc] init];
            wf8.imageUrl = imageName[i];
            // 获取图片的size
//            CGSize size = [UIImage imageNamed:imageName[i]].size;
            wf8.width = SCREEN_WIDTH/2-Cell_Space*2;
            wf8.height = SCREEN_WIDTH/2-Cell_Space*2;//SCREEN_WIDTH/size.width*size.height/2-20;
//            NSLog(@"%@,%f",name[i],SCREEN_WIDTH/size.width*size.height);
            [_temps addObject:wf8];
        }
    }
    return _temps;
}

@end


