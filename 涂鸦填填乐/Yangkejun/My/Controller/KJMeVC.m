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

#import "KJChangeNameVC.h"
#import "KJPersionSignViewController.h"
#import "KJMeForUSVC.h"
#import "KJMeSkinThemeVC.h"

#import "KJTouchIDVC.h" // ThouchID
#import "KJGestureSetupVC.h" // 手势密码

//// 全局变量
static UIStatusBarStyle style_ = UIStatusBarStyleDefault;
static BOOL statusBarHidden_ = NO;
@interface KJMeVC ()<CHTCollectionViewDelegateWaterfallLayout>
/// temps
@property (nonatomic,readwrite,strong) NSMutableArray *temps;

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel  *nameLabel;
@property (nonatomic, strong) UILabel  *contentLabel;

/// 自定义的导航条
@property (nonatomic, readwrite, weak)UIView *navBar;

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
        self.shouldPullUpToLoadMore = NO;
        self.shouldPullDownToRefresh = YES;
        
        [self.dataSource addObjectsFromArray:self.temps];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // hide sys navBar
    self.fd_prefersNavigationBarHidden = NO;
    
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
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
                   withReuseIdentifier:@"footerView"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;//这里很关键，分两组，把banner放在第一组的footer，把分类按钮放在第二组的header
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
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

- (void)collectionViewDidTriggerFooterRefresh{
    /// 下拉加载事件 子类重写
    self.page = self.page + 1;
    /// 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //        /// 模拟数据
        //        /// 假设第3页的时候请求回来的数据 < self.perPage 模拟网络加载数据不够的情况
        //        NSInteger count = (self.page >= 4)?18:self.perPage;
        //
        //        for (NSInteger i = 0; i < count; i++) {
        //            [self.dataSource addObject:self.temps[[NSObject kj_randomNumber:0 to:10]]];
        //        }
        
        [self.dataSource addObjectsFromArray:self.temps];
        
        /// 告诉系统你是否结束刷新 , 这个方法我们手动调用，无需重写
        [self collectionViewDidFinishTriggerHeader:NO reload:YES];
    });
}

#pragma mark - 事件处理Or辅助方法
- (void)headerImageEvent:(UITapGestureRecognizer *)gesture{
    _weakself;
    
    [[KJPhotoChangeManager manager] showInVC:self Name:@"更换头像图片" image:^(UIImage *image) {
        weakself.headerImageView.image = image;
        
        // 先返回图片所在的沙盒路径,先删除以前的那张
        [KJTools clearCachesWithFilePath:[KJTools getImagePathWithName:@"my_header_image"]];
        // 保存到沙盒
        [KJTools saveImage:image withName:@"my_header_image"];
        
        //                    [UIView loadTitle:@"头像图片上传中..." toView:self.view];
        //                    [KJTencentUploadTools uploadFileWithImage:image uploadSuccess:^(NSString *resp) {
        //                        [UIView kj_loadingHideFromView:self.view];
        //                        // 图片已上传至腾讯云存储
        //                        self->ischangeHead=YES;
        //                        weakself.headerImageUrl = resp;
        //                        weakself.changeInfoString = resp;
        //                        [weakself.mainTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        //                    } uploadFailed:^(NSDictionary *dict) {
        //                        [UIView kj_loadingHideFromView:self.view];
        //                    }];
    }];
}

#pragma mark - UICollectionViewDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return SCREEN_HEIGHT/4+kSTATUSBAR_NAVIGATION_HEIGHT;
    }else{
        return 0.0001;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        if (indexPath.section==0) {
            if (reusableView.subviews.count == 0) {//加一个限制，避免无限创建新的
                // 返回图片所在的沙盒路径
                NSString *cover_path = [KJTools getImagePathWithName:@"my_cover_image"];
                UIImage *cover_image = [UIImage imageWithContentsOfFile:cover_path]!=nil ? [UIImage imageWithContentsOfFile:cover_path]:GetImage(@"Mybg-1");
                UIImageView*bgImageView = InsertImageView(reusableView, CGRectZero, cover_image);
                bgImageView.contentMode = UIViewContentModeScaleToFill;
                self.bgImageView = bgImageView;
                [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(UIEdgeInsetsZero);
                }];
//                // 毛玻璃滤镜
//                UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//                UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
//                UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:vibrancyEffect];
//                UIView *redView = [[UIView alloc]init];
//                redView.backgroundColor = [UIColor whiteColor];
//                redView.alpha = 0.5;
//                [visualView.contentView addSubview:redView];
//                visualView.frame = _bgImageView.bounds;
//                redView.frame = visualView.bounds;
//                [bgImageView addSubview:visualView];
                
                // 返回图片所在的沙盒路径
                NSString *header_path = [KJTools getImagePathWithName:@"my_header_image"];
                UIImage *header_image = [UIImage imageWithContentsOfFile:header_path] != nil ? [UIImage imageWithContentsOfFile:header_path] : GetImage(@"LOGOstore_1024pt");
                UIImageView*headerImageView = InsertImageView(reusableView, CGRectZero, header_image);
                [KJTools makeCornerRadius:SCREEN_HEIGHT/14 borderColor:MainColor(1) layer:headerImageView.layer borderWidth:0.5];
                // 添加手势
                headerImageView.userInteractionEnabled = YES; // 打开用户交互(不可少)
                UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageEvent:)];
                // 将手势添加到需要相应的view中去
                [headerImageView addGestureRecognizer:tapGesture];
                // 选择触发事件的方式（默认单机触发）
                [tapGesture setNumberOfTapsRequired:1];
                
                [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(reusableView).mas_offset(Handle(10)+kSTATUSBAR_NAVIGATION_HEIGHT);
                    make.centerX.mas_equalTo(reusableView);
                    make.width.height.mas_equalTo(SCREEN_HEIGHT/7);
                }];
                self.headerImageView = headerImageView;
                UILabel*_nameLabel=InsertLabel(reusableView, CGRectZero, NSTextAlignmentCenter, kAppName, SystemFontSize(16), [UIColor blackColor]);
                _nameLabel.theme_textColor = @"text_h1";
                [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_equalTo(headerImageView);
                    make.height.mas_equalTo(Handle(20));
                    make.top.mas_equalTo(headerImageView.mas_bottom).mas_offset(5);
                }];
                self.nameLabel = _nameLabel;
                UILabel*Label=InsertLabel(reusableView, CGRectZero, NSTextAlignmentCenter, @"一千个人眼中就有一千个哈姆雷特", SystemFontSize(14), [UIColor lightGrayColor]);
                Label.numberOfLines = 0;
                self.contentLabel = Label;
                [Label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_nameLabel.mas_bottom).mas_offset(5);
                    make.right.mas_equalTo(reusableView).mas_offset(Handle(-10));
                    make.left.mas_equalTo(reusableView).mas_offset(Handle(10));
                }];
            }
        }else{
            [reusableView removeAllSubviews];
        }
    }
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{ // 设置主题
//                KJChangeNameVC *vc = [[KJChangeNameVC alloc] init];
//                vc.vcType = HNChangeUserInfoVCTypeNick;
//                vc.string = @"77";
//                _weakself;
//                vc.myBlock = ^(NSString *nickName) {
//                    weakself.nameLabel.text = nickName;
//                };
                KJMeSkinThemeVC *vc = [[KJMeSkinThemeVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:{ // 修改个性签名
                KJPersionSignViewController *vc = [[KJPersionSignViewController alloc] init];
                vc.infro = @"个性签名";
                _weakself;
                vc.myBlock = ^(NSString *intro) {
                    weakself.contentLabel.text = intro;
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:{ // 修改背景封面
                _weakself;
                [[KJPhotoChangeManager manager] showInVC:self Name:nil image:^(UIImage *image) {
                    weakself.bgImageView.image = image;
                    // 先返回图片所在的沙盒路径,先删除以前的那张
                    [KJTools clearCachesWithFilePath:[KJTools getImagePathWithName:@"my_cover_image"]];
                    // 保存到沙盒
                    [KJTools saveImage:image withName:@"my_cover_image"];
                }];
            }
                break;
            case 3:{ // 设置手势密码
                KJGestureSetupVC *gesture = [[KJGestureSetupVC alloc]init];
                [self.navigationController pushViewController:gesture animated:YES];
            }
                break;
            case 4:{ // 设置ThouchID
                KJTouchIDVC *vc = [[KJTouchIDVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:{ // 关于我们
                KJMeForUSVC *vc = [[KJMeForUSVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 6:{ //   给我们评分
                NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", kAppID];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }
                break;
            case 7:{ // 清除缓存
                KJAlertView *view = [[KJAlertView alloc] initWithTitle:nil Content:@"是否清理缓存" whitTitleArray:@[@"取消",@"确定"] withType:@"center"];
                [view showAlertView:^(NSInteger index) {
                    if (index == 1) {
                        [MBProgressHUD showSuccess:NSLocalizedString(@"清除缓存成功!!!", nil)];
//                        //清除图片缓存
//                        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
//                        [[SDImageCache sharedImageCache] clearMemory];//可不写
                        
                        // 先返回图片所在的沙盒路径,先删除以前的那张
                        [KJTools clearCachesWithFilePath:[KJTools getImagePathWithName:@"my_cover_image"]];
                        [KJTools clearCachesWithFilePath:[KJTools getImagePathWithName:@"my_header_image"]];
                        
                        [self.collectionView reloadData];
                    }
                }];
                [self.view addSubview:view];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark - CHTCollectionViewDelegateWaterfallLayout
/// 子类必须override
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    KJWaterfall *waterfall = self.dataSource[indexPath.item];
    return CGSizeMake(waterfall.width, waterfall.height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat duration = 0.65;
    CGFloat navBarAlhpa = (offsetY >= kSTATUSBAR_NAVIGATION_HEIGHT)?1.0:0.0;
    navBarAlhpa = (offsetY - kSTATUSBAR_NAVIGATION_HEIGHT)/ kSTATUSBAR_NAVIGATION_HEIGHT + 1;
    
    [UIView animateWithDuration:duration animations:^{
        self.navBar.backgroundColor = MainColor(navBarAlhpa);
    }];
}

#pragma mark - 初始化
- (void)_setup{
    self.collectionView.frame = CGRectMake(0, -kSTATUSBAR_NAVIGATION_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT+kSTATUSBAR_NAVIGATION_HEIGHT-kTABBAR_HEIGHT);
    self.collectionView.theme_backgroundColor = @"block_bg";
}

#pragma mark - 设置导航栏
- (void)_setupNavigationItem{
    /// Create NavBar;
    //    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kSTATUSBAR_NAVIGATION_HEIGHT)];
    //    self.navBar = navBar;
    //    [self.view addSubview:navBar];
    //    UILabel*_nameLabel=InsertLabel(navBar, CGRectZero, NSTextAlignmentCenter, @"个人中心", SystemFontSize(18), [UIColor blackColor]);
    //    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.mas_equalTo(self.view);
    //        make.height.mas_equalTo(Handle(20));
    //        make.bottom.mas_equalTo(navBar.mas_bottom).mas_offset(-10);
    //    }];
    //    // 放在最顶层
    //    [self.view bringSubviewToFront:_nameLabel];
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
        NSArray *name = @[@"设置主题",@"修改个性签名",@"更换背景",@"设置手势密码",@"设置TouchID解锁",@"关于我们",@"给我们评分",@"清除缓存"];
        NSArray *imageName = @[@"1101017",@"1101022",@"1101045",@"1101031",@"1101030", @"1101053",@"1101018",@"1101054"];
        int a = (int)name.count;
        for (int i=0; i<a; i++) {
            KJWaterfall *wf8 = [[KJWaterfall alloc] init];
            wf8.title = name[i];
            wf8.imageUrl = imageName[i];
            wf8.width = SCREEN_WIDTH;
            wf8.height = Cell_Height;
            [_temps addObject:wf8];
        }
    }
    return _temps;
}

@end

