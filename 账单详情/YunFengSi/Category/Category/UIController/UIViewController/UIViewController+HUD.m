//
//  UIViewController+KJHUD.m
//  KJDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

//导航栏高度
static CGFloat const KJNavigationBarHeight = 64;
//tabBar高度
static CGFloat const KJTabBarHeight = 49;

static const void *MBProgressHUDKey = &MBProgressHUDKey;

@implementation UIViewController (KJHUD)

- (MBProgressHUD *)hud{
    return objc_getAssociatedObject(self, MBProgressHUDKey);
}

- (void)setHud:(MBProgressHUD *)hud{
    objc_setAssociatedObject(self, MBProgressHUDKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)kj_showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = hint;
    [self setHud:hud];
}

- (void)kj_showHint:(NSString *)hint{
    [self kj_showBottomHint:hint];
}
/**
 *  在window上显示HUD
 *  显示在底部
 *  @param hint 显示内容
 */
- (void)kj_showBottomHint:(NSString *)hint{
    // 显示提示信息
    [self kj_showHint:hint yOffset:([UIScreen mainScreen].bounds.size.height*0.5-KJTabBarHeight-KJTabBarHeight*0.5)];
}
/**
 *  在window上显示HUD
 *  显示在顶部
 *  @param hint 显示内容
 */
- (void)kj_showTopHint:(NSString *)hint{
    // 显示提示信息
    [self kj_showHint:hint yOffset:-([UIScreen mainScreen].bounds.size.height*0.5-KJNavigationBarHeight-KJNavigationBarHeight*0.2)];
}


- (void)kj_showHint:(NSString *)hint yOffset:(float)yOffset{
    // 先hide掉之前的hud
    [self kj_hideHud];
    
    // 显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    // HUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = hint;
    hud.label.font = KJMediumFont(14.0f);
    hud.margin = 10.f;
    // 改变hud 内容的颜色
    hud.contentColor = [UIColor whiteColor];
    // HUD 显示框
    hud.bezelView.color = [UIColor blackColor];
    // HUD透明度
    hud.bezelView.alpha = 0.95;
    
    // 偏移量
    CGPoint offset = CGPointMake(hud.offset.x, yOffset);
    hud.offset = offset;
    // 两秒后移除删除
    [hud hideAnimated:YES afterDelay:2.0f];
    
    self.hud = hud;
}

- (void)kj_hideHud{
    [[self hud] hideAnimated:YES];
}


@end
