//
//  MBProgressHUD+NJ.h
//
//  Created by 李南江 on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  指示器

#import "MBProgressHUD.h"

@interface MBProgressHUD (PX)

#pragma mark - 放在window位置
// 成功显示
+ (void)showSuccess:(NSString *)success;
// 失败显示
+ (void)showError:(NSString *)error;
// 显示消息
+ (MBProgressHUD *)showMessage:(NSString *)message;
// 隐藏
+ (void)hideHUD;

#pragma mark - 放在指定view上
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;


@end
