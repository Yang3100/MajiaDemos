//
//  HomeViewController.m
//  XinMinClub
//
//  Created by yangkejun on 16/3/19.
//  Copyright © 2016年 yangkejun. All rights reserved.
//

#import "HomeViewController.h"
#import "KJFilterVC.h"
#import "KJCameraVC.h"
#import "KJHistoryVC.h"

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)

@interface HomeViewController ()<KJCameraDelegate>

@end

@implementation HomeViewController

- (NSArray<NSString *> *)titles {
    return @[@"拍照",@"滤镜",@"历史"];
}

- (instancetype)init{
    if (self = [super init]) {
        // 设置第三方库的WMPageController的一些属性
        self.showOnNavigationBar = YES;
        self.navigationBarNum = 2;
        self.pageAnimatable = YES;
        self.titleSizeSelected = 20;
        self.titleSizeNormal = 18;
        self.menuBGColor = [UIColor clearColor];
        self.titleColorNormal = UIColor.blueColor;
        self.titleColorSelected = UIColor.redColor;
        self.selectIndex = 1;
        self.preloadPolicy = 1;
        self.progressHeight = 2;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.isOpenScroll = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBarButtonItems];
}

// 设置按钮
- (void)setBarButtonItems {
    // 左侧消息按钮
    UIImage *rightImage = [[UIImage imageNamed:@"abc_ed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(SetAction)];
    self.navigationItem.leftBarButtonItem = rightButtonItem;
    
    // 右侧消息按钮
    UIImage *leftImage = [[UIImage imageNamed:@"abc_ed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(PlayAction)];
    self.navigationItem.rightBarButtonItem = leftButtonItem;
}

#pragma mark - NavigationBar事件
- (void)SetAction{
    
}
- (void)PlayAction{
    
}

#pragma mark - WMPageController DataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index==0) {
        KJCameraVC *vc = [[KJCameraVC alloc] init];
        vc.delegate = self;
        return vc;
    }
    else if (index==2){
        KJHistoryVC *vc = [[KJHistoryVC alloc] init];
        return vc;
    }
    else{
        KJFilterVC *vc = [[KJFilterVC alloc] init];
        return vc;
    }
}

- (void)pageController:(WMPageController *)pageController lazyLoadViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{

}

- (void)pageController:(WMPageController *)pageController willCachedViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
}


#pragma mark - CameraDelegate
- (void)kj_cameraTakePhoto:(UIImage *)image{
    //选取照片的回调
    NSLog(@"-----%@",image);
    self.selectIndex = 1;
}

@end
