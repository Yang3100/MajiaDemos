//
//
//  MBProgressHUD+KJExtension.m
//
//  Created by apple on 16/5/10.
//  Copyright © 2016年 杨科军. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (KJExtension)

/// in window
/// 提示信息
+ (MBProgressHUD *)kj_showTips:(NSString *)tipStr;

/// 提示错误
+ (MBProgressHUD *)kj_showErrorTips:(NSString *)error;

/// 进度view
+ (MBProgressHUD *)kj_showProgressHUD:(NSString *)titleStr;

/// 隐藏hud
+ (void)kj_hideHUD;



/// in special view
/// 提示信息
+ (MBProgressHUD *)kj_showTips:(NSString *)tipStr addedToView:(UIView *)view;
/// 提示错误
+ (MBProgressHUD *)kj_showErrorTips:(NSString *)error addedToView:(UIView *)view;
/// 进度view
+ (MBProgressHUD *)kj_showProgressHUD:(NSString *)titleStr addedToView:(UIView *)view;

/// 隐藏hud
+ (void)kj_hideHUDForView:(UIView *)view;


@end
