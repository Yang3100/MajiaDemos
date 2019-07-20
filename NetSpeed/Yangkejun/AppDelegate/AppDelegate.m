//
//  AppDelegate.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "AppDelegate.h"
#import "TouchIdUnlock.h"
#import "LZGestureTool.h"
#import "LZGestureScreen.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 跳转到appDelegate扩展KJCustom类实现其他功能didReceiveRemoteNotification
    [self configSystem:launchOptions];
    
    // 指纹解锁
    [self setThouchID];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    KJBaseTabBarController *vc = [[KJBaseTabBarController alloc] init];
    self.window.rootViewController = vc;
    
    return YES;
}

- (void)setThouchID{
    if ([LZGestureTool isGestureEnable]) {
        [[LZGestureScreen shared] show];
        if ([[TouchIdUnlock sharedInstance] canVerifyTouchID]) {
            [[TouchIdUnlock sharedInstance] startVerifyTouchID:^{
                [[LZGestureScreen shared] dismiss];
            }];
        }
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    // 解锁屏幕即调用
    // 指纹解锁
    [self setThouchID];
}

@end
