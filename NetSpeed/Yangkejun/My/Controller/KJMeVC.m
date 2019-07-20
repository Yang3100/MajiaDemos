//
//  KJMeVC.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJMeVC.h"
#import "KJWaterfall.h"
#import "KJWaterfallCell.h"
// 瀑布流
#import <CHTCollectionViewWaterfallLayout.h>

#import "KJPersionSignViewController.h"
#import "KJMeForUSVC.h"

#import "KJTouchIDVC.h" // ThouchID
#import "KJGestureSetupVC.h" // 手势密码

@interface KJMeVC ()<CHTCollectionViewDelegateWaterfallLayout>
/// temps
@property (nonatomic,readwrite,strong) NSMutableArray *temps;

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel  *subTitLabel;
@property (nonatomic, strong) UILabel  *contentLabel;

@end

@implementation KJMeVC

/// 重写init方法，配置你想要的属性
- (instancetype)init{
    if (self=[super init]) {
        /// create collectionViewLayout
        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumColumnSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.columnCount = 1; // 每行个数
        layout.footerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.collectionViewLayout = layout;
        self.perPage = 30;
        
        /// 支持上下拉加载和刷新
        self.shouldPullUpToLoadMore = YES;
        self.shouldPullDownToRefresh = NO;
        
        [self.dataSource addObjectsFromArray:self.temps];
    }
    return self;
}
#pragma mark - Status bar
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationFade;
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
    [self.collectionView registerClass:[KJWaterfallCell class]
            forCellWithReuseIdentifier:@"KJWaterfallCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;//这里很关键，分两组，把banner放在第一组的footer，把分类按钮放在第二组的header
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"KJWaterfallCell" forIndexPath:indexPath];
}

- (void)configureCell:(KJWaterfallCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object{
    [cell configureModel:object];
}

- (void)collectionViewDidTriggerHeaderRefresh{
    /// 下拉刷新事件 子类重写
    self.page = 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        /// 清掉数据源
        [self.dataSource removeAllObjects];
        
        /// 模拟数据
        //        for (NSInteger i = 0; i < self.perPage; i++) {
        //            [self.dataSource addObject:self.temps[[NSObject kj_randomNumber:0 to:self.temps.count]]];
        //        }
        [self.dataSource addObjectsFromArray:self.temps];
        
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self collectionViewDidFinishTriggerHeader:YES reload:YES];
    });
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        switch (indexPath.row) {
            case 0:{ // 修改个性签名
                KJPersionSignViewController *vc = [[KJPersionSignViewController alloc] init];
                vc.infro = @"There are a thousand hamlets in the eyes of a thousand";
                _weakself;
                vc.myBlock = ^(NSString *intro) {
                    weakself.subTitLabel.text = intro;
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{ // 修改背景封面
                _weakself;
                [[KJPhotoChangeManager manager] showInVC:self Name:nil image:^(UIImage *image) {
                    weakself.bgImageView.image = image;
                }];
            }
                break;
            case 2:{ // 设置手势密码
                KJGestureSetupVC *gesture = [[KJGestureSetupVC alloc]init];
                [self.navigationController pushViewController:gesture animated:YES];
            }
                break;
            case 3:{ // 设置ThouchID
                KJTouchIDVC *vc = [[KJTouchIDVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:{ // 关于我们
                KJMeForUSVC *vc = [[KJMeForUSVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:{ //   给我们评分
                NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", kAppID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }
                break;
            case 6:{ // 清除缓存
                KJAlertView *view = [[KJAlertView alloc] initWithTitle:nil Content:@"Clear the cache?" whitTitleArray:@[@"cancel",@"sure"] withType:@"center"];
                [view showAlertView:^(NSInteger index) {
                    if (index == 1) {
                        [MBProgressHUD showSuccess:NSLocalizedString(@"Clear the cache successfully!!!", nil)];
                        
                    }
                }];
                [self.view addSubview:view];
            }
                break;
            default:
                break;
        }
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
/// 子类必须override
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    KJWaterfall *waterfall = self.dataSource[indexPath.item];
    return CGSizeMake(waterfall.width, waterfall.height);
}

#pragma mark - 初始化
- (void)_setup{
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    self.collectionView.backgroundColor = [UIColor clearColor];
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    // hide sys navBar
    self.fd_prefersNavigationBarHidden = YES;
    /// Create NavBar;
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, kSTATUSBAR_HEIGHT-20, kScreenW, self.navigationController.navigationBar.height+20)];
    navBar.backgroundColor = MainColor(1.f);
    [self.view addSubview:navBar];
    
    UILabel *tit = InsertLabel(navBar, CGRectZero, NSTextAlignmentCenter, @"Personal Center", [UIFont fontWithName:@"Futura" size:24], [UIColor whiteColor]);
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(navBar.mas_bottom).mas_offset(-Handle(10));
        make.centerX.mas_equalTo(self.view);
    }];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *bg = InsertImageView(self.view, CGRectZero, DefaultBGImage);
    bg.frame = self.view.bounds;
    bg.alpha = 0.6;
    [self.view sendSubviewToBack:bg];
    
    UILabel *subTit = InsertLabel(self.view, CGRectZero, NSTextAlignmentCenter, @"There are a thousand hamlets in the eyes of a thousand", [UIFont fontWithName:@"Futura" size:14], [UIColor whiteColor]);
    self.subTitLabel = subTit;
    subTit.numberOfLines = 0;
    [subTit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-Handle(kTABBAR_HEIGHT+40));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
    }];
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
        NSArray *name = @[@"Modified signature",@"Change background",@"Set gesture password",@"set TouchID",@"For us",@"Grade us",@"Clear cache"];
        NSArray *imageName = @[@"1101022",@"1101045",@"1101031",@"1101030", @"1101053",@"1101018",@"1101054"];
        int a = (int)name.count;
        for (int i=0; i<a; i++) {
            KJWaterfall *wf8 = [[KJWaterfall alloc] init];
            wf8.title = name[i];
            wf8.imageUrl = imageName[i];
            wf8.width = SCREEN_WIDTH;
            wf8.height = 50;
            [_temps addObject:wf8];
        }
    }
    return _temps;
}

@end

