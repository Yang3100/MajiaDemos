//
//  AppDelegate.m
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "AppDelegate.h"
#import "KJHomeVC.h"
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
    
    // 判断是不是第一次启动app
    [self kj_firstInstallation];
    
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

/************** 判断是不是第一次启动app *****************/
- (void)kj_firstInstallation{
//    BOOL firstInstallation = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstInstallation"];
//    BOOL loggedOut = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedOut"];
//    if (!firstInstallation){  // 第一次启动
//        if (loggedOut){
//            KJLoginVC *vc = [[KJLoginVC alloc] init];
//            self.window.rootViewController = vc;
//        }else{
//            self.window.rootViewController = [KJLaunchVC kj_LaunchViewController];
//        }
//    }
//    else{
//        if (kUserID == nil || [kUserID isEqualToString:@""]){  // 登录注册界面
//            KJLoginVC *vc = [[KJLoginVC alloc] init];
//            self.window.rootViewController = vc;
//        }
//        else{  // 自动登录
            KJBaseTabBarController *vc = [[KJBaseTabBarController alloc] init];
            self.window.rootViewController = vc;
//            self.tabBar = vc;
//        }
//    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    // 解锁屏幕即调用
    // 指纹解锁
    [self setThouchID];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started)while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self){
        if (_persistentContainer == nil){
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"YunFengSi"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error){
                if (error != nil){
                    // Replace this implementation with code to handle the error appropriately.
                    // abort()causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]){
        // Replace this implementation with code to handle the error appropriately.
        // abort()causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
