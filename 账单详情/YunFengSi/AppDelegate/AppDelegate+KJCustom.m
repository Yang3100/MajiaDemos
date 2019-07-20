//
//  AppDelegate+KJCustom.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "AppDelegate+KJCustom.h"

@implementation AppDelegate (KJCustom)

- (void)configSystem:(NSDictionary *)options{
    
    /************** 自动管理键盘配置 *****************/
    [self setIQKeyboardManager];
}

- (void)setIQKeyboardManager{
    // 自动管理键盘配置
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = YES;
}

@end
