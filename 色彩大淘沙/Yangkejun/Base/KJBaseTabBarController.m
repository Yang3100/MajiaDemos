//
//  KJBaseTabBarController.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseTabBarController.h"
#import "KJBaseCustomTabBar.h"
#import "KJMeVC.h"
#import "KJStadyVC.h"
#import "KJSimpleDrawVC.h"

@interface KJBaseTabBarController ()<KJBaseCustomTabBarDelegate>

@property (nonatomic,weak) KJBaseCustomTabBar *basetabBar;

@end

@implementation KJBaseTabBarController

+ (void)initialize{
    // tabBaritme 标题未选中的 颜色 大小设置
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    normalAttrs[NSForegroundColorAttributeName] = normalAttrs[NSForegroundColorAttributeName];
    
    // tabBaritme 标题选中的 颜色 大小设置
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = MainColor(1);
    
    UITabBarItem *item = [UITabBarItem appearance];
//    [item theme_setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 首页
    KJBaseNavigationController *homeNav = ({
        KJStadyVC *vc = [[KJStadyVC alloc]init];
        // 配置
        vc.title = @"色彩大淘沙";
        // 添加到导航栏的栈底控制器
        [[KJBaseNavigationController alloc] initWithRootViewController:vc];
    });
    // 首页
    KJBaseNavigationController *drawNav = ({
        KJSimpleDrawVC *vc = [[KJSimpleDrawVC alloc]init];
        // 配置
        vc.title = @"排行榜";
        // 添加到导航栏的栈底控制器
        [[KJBaseNavigationController alloc] initWithRootViewController:vc];
    });
    // 我的
    KJBaseNavigationController *meNav = ({
        KJMeVC *vc = [[KJMeVC alloc]init];
        // 配置
        vc.title = @"个人中心";
        // 添加到导航栏的栈底控制器
        [[KJBaseNavigationController alloc] initWithRootViewController:vc];
    });
    
    [self setupChildVC:homeNav title:@"图库" image:@"huaban_nor" selectedImage:@"huaban"];
    [self setupChildVC:drawNav title:@"成就" image:@"chuchuang_nor" selectedImage:@"chuchuang"];
    [self setupChildVC:meNav title:@"我的" image:@"wode_nor" selectedImage:@"wode"];
    /// 默认选择第二个
//    self.selectedIndex = 1;
    
    // 更改系统自带的tabbar
    UITabBar *tabbar = [[UITabBar alloc] init];
//    tabbar.tabbardelegate = self;
//    self.basetabBar = tabbar;
    [self setValue:tabbar forKey:@"tabBar"];
//    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setTheme_barTintColor:@"tabbar_bg_color"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置tabBar子控制器 item 标题，以及图片
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片
    vc.tabBarItem.title = title;
//    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTheme_image:image];
    [vc.tabBarItem setTheme_selectedImage:selectedImage];
    
    [self addChildViewController:vc];
}

#pragma mark - tabbar点击效果
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSInteger index = [tabBar.items indexOfObject:item];
    // 添加动画
    [self animationWithindex:index];
}

- (void)animationWithindex:(NSInteger)index{
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews){
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *anim =[CABasicAnimation  animation];
    //    想让哪一个图层做动画,就添加到哪一个图层上面.
    anim.keyPath = @"transform.scale";
    //    缩放到最小
    anim.toValue = @1.3;
    //    设置动画执行的次数
    anim.repeatCount = 3;
    //    设置动画执行的时长
    anim.duration = 0.1;
    //    反转
    anim.autoreverses = YES;
    
    [[tabbarbuttonArray[index] layer] addAnimation:anim forKey:nil];
}

@end




