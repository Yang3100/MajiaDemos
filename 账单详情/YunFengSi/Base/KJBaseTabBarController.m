//
//  KJBaseTabBarController.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/20.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseTabBarController.h"
#import "KJBaseCustomTabBar.h"
#import "KJHomeVC.h"
#import "KJMeVC.h"
#import "KJTallyVC.h"

#import "KJPresentation.h"
#import "KJBubbleAnimation.h"

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
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 首页
    KJBaseNavigationController *homeNav = ({
        KJHomeVC *vc = [[KJHomeVC alloc]init];
        // 配置
        vc.title = @"账单";
        // 添加到导航栏的栈底控制器
        [[KJBaseNavigationController alloc] initWithRootViewController:vc];
    });
    // 我的
    KJBaseNavigationController *meNav = ({
        KJMeVC *vc = [[KJMeVC alloc]init];
        // 配置
        vc.title = @"我的";
        // 添加到导航栏的栈底控制器
        [[KJBaseNavigationController alloc] initWithRootViewController:vc];
    });
    
    [self setupChildVC:homeNav title:@"账单统计" image:@"xuexi" selectedImage:@"xuexi_ed"];
    [self setupChildVC:meNav title:@"个人中心" image:@"my" selectedImage:@"my_ed"];
    /// 默认选择第二个
//    self.selectedIndex = 1;
    
    // 更改系统自带的tabbar
    KJBaseCustomTabBar *tabbar = [[KJBaseCustomTabBar alloc] init];
    tabbar.tabbardelegate = self;
    self.basetabBar = tabbar;
    [self setValue:tabbar forKey:@"tabBar"];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置tabBar子控制器 item 标题，以及图片
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
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

#pragma mark - KJBaseCustomTabBarDelegate
- (void)tabBarDidClickLiveButton:(KJBaseCustomTabBar *)tabBar{
    NSLog(@"123");
    KJTallyVC *vc = [[KJTallyVC alloc] init];
    // 气泡缩放动画过渡转场
    [self presentationBubbleAnimationFromVC:self ToVC:vc Frame:CGRectMake(SCREEN_WIDTH/2-Handle(30), SCREEN_HEIGHT-kTABBAR_HEIGHT/2-Handle(35), Handle(60), Handle(60)) StrokeColor:[UIColor whiteColor]];
}

#pragma mark - 转场动画
// Bubble样式的转场动画效果 sourceRect:从什么位置产生气泡  StrokeColor:填充颜色
- (void)presentationBubbleAnimationFromVC:(UIViewController*)fromVC ToVC:(UIViewController*)toVC Frame:(CGRect)sourceRect StrokeColor:(UIColor*)strokeColor{
    KJBubbleAnimation *bubble = [[KJBubbleAnimation alloc] init];
    bubble.sourceRect  = sourceRect;
    bubble.strokeColor = strokeColor;
    [KJPresentation presentWithPresentationAnimation:bubble presentedViewController:toVC presentingViewController:fromVC];
}

@end




