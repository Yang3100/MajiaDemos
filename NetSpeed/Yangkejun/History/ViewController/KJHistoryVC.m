//
//  KJHistoryVC.m
//  网速大师傅
//
//  Created by 杨科军 on 2018/11/9.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJHistoryVC.h"
#import "KJHistoryCell.h"
#import "KJHomeModel.h"
#import "KJHistoryModel.h"

@interface KJHistoryVC ()

/// 滚动到顶部的按钮
@property (nonatomic, readwrite, weak)UIButton *scrollToTopButton;
/// 自定义的导航条
@property (nonatomic, readwrite, weak)UIView *navBar;

@end

@implementation KJHistoryVC
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
    
    // hide sys navBar
    self.fd_prefersNavigationBarHidden = YES;
    // 去掉侧滑pop手势
    self.fd_interactivePopDisabled = YES;
    
    [self _setup];
    
    // create subViews
    [self setUI];
    
    // deal action
    [self dealAction];
    
    /// tableView rigister  cell
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"KJHistoryCell" bundle:nil] forCellReuseIdentifier:@"KJHistoryCell"];
    
    /// bind viewModel
    [self bindViewModel];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self tableViewDidTriggerHeaderRefresh];
}

#pragma mark - 初始化
- (void)_setup{
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH-kTABBAR_HEIGHT);
    self.perPage = 10;
    
    // 上下拉刷新
    self.shouldPullDownToRefresh = YES;
    self.shouldPullUpToLoadMore = NO;
}

#pragma mark - BindModel
- (void)bindViewModel{
    // kvo
    
}

#pragma mark - 事件处理
/// 事件处理
- (void)dealAction{
    
}
/// 滚动到顶部
- (void)_scrollToTop {
    [self.tableView setContentOffset:CGPointMake(0, 0)animated:YES];
}

#pragma mark - Override
/// 下拉刷新
- (void)tableViewDidTriggerHeaderRefresh{
    /// config param
    self.page = 1;
    self.lastPage = 3;
    /// 请求商品数据
    /// 请求商品数据 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.05f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        /// 移除掉数据
        [self.dataSource removeAllObjects];
        NSArray *datas = [[KJHomeModel sharedInstance] getAllDatas];
        [self.dataSource addObjectsFromArray:datas];
        /// 结束头部控件的刷新并刷新数据
        [self tableViewDidFinishTriggerHeader:YES reload:YES];
    });
}
/// 上拉加载
- (void)tableViewDidTriggerFooterRefresh{
    /// config param
    self.page+=1;
    /// 请求商品数据
    /// 请求商品数据 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.75f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataSource removeAllObjects];
        /// 获取数据
        NSArray *datas = [[KJHomeModel sharedInstance] getAllDatas];
        [self.dataSource addObjectsFromArray:datas];
        /// 结束尾部控件的刷新并刷新数据
        [self tableViewDidFinishTriggerHeader:NO reload:YES];
    });
}

/// config  cell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    KJHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KJHistoryCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

/// 文本内容区域
- (UIEdgeInsets)contentInset{
    return UIEdgeInsetsZero;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /// 由于使用系统的autoLayout来计算cell的高度，每次滚动时都要重新计算cell的布局以此来获得cell的高度 这样一来性能不好
    /// 所以笔者采用实现计算好的cell的高度
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 跳转到商品详请
    
}

////////////////// 以下为UI代码，不必过多关注 ///////////////////
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    /// FIXED : when data is empty ，the backgroundColor is exist
    return (self.dataSource.count==0)?.0001f:kSTATUSBAR_NAVIGATION_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    /// FIXED : when data is empty ，show nothing
    if (self.dataSource.count==0)return nil;

    UILabel *la = InsertLabel(nil, CGRectMake(0, 0, SCREEN_WIDTH, kSTATUSBAR_NAVIGATION_HEIGHT), NSTextAlignmentLeft, @"", SystemFontSize(14), MainColor(1));
    la.backgroundColor = [UIColor clearColor];
    return la;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    self.scrollToTopButton.hidden = (offsetY < scrollView.height);
    
    CGFloat duration = 0.65;
    CGFloat navBarAlhpa = (offsetY >= kSTATUSBAR_NAVIGATION_HEIGHT)?1.0:0.1;
    
    navBarAlhpa = (offsetY - kSTATUSBAR_NAVIGATION_HEIGHT)/ kSTATUSBAR_NAVIGATION_HEIGHT + 1;
    
    [UIView animateWithDuration:duration animations:^{
        self.navBar.backgroundColor = MainColor(navBarAlhpa);
    }];
}

#pragma mark - 初始化子控件
- (void)setUI{
    /// Create NavBar;
    UIView *navBar = [[UIView alloc] initWithFrame:CGRectMake(0, kSTATUSBAR_HEIGHT-20, kScreenW, self.navigationController.navigationBar.height+20)];
    navBar.backgroundColor = MainColor(0.1f);
    self.navBar = navBar;
    [self.view addSubview:navBar];
    
    UILabel *tit = InsertLabel(navBar, CGRectZero, NSTextAlignmentCenter, @"History", [UIFont fontWithName:@"Futura" size:24], [UIColor whiteColor]);
    [tit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(navBar.mas_bottom).mas_offset(-Handle(10));
        make.centerX.mas_equalTo(self.view);
    }];
    
    /// 滚动到顶部的按钮
    CGFloat scrollToTopButtonW = 90;
    CGFloat scrollToTopButtonH = 100;
    CGFloat scrollToTopButtonX = (kScreenW - scrollToTopButtonW)- 12;
    CGFloat scrollToTopButtonY = (kScreenH - scrollToTopButtonH)- 60;
    UIButton *scrollToTopButton = [[UIButton alloc] initWithFrame:CGRectMake(scrollToTopButtonX, scrollToTopButtonY, scrollToTopButtonW, scrollToTopButtonH)];
    [scrollToTopButton setImage:[UIImage imageNamed:@"go_top"] forState:UIControlStateNormal];
    scrollToTopButton.hidden = YES;
    self.scrollToTopButton = scrollToTopButton;
    [self.view addSubview:scrollToTopButton];
    //// 添加事件处理
    [scrollToTopButton addTarget:self action:@selector(_scrollToTop)forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIImageView *bg = InsertImageView(self.view, CGRectZero, DefaultBGImage);
    bg.frame = self.tableView.bounds;
    bg.alpha = 0.6;
    [self.view sendSubviewToBack:bg];
}

@end
