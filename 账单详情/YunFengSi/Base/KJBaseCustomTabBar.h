//
//  KJBaseCustomTabBar.h
//  LiveShow
//
//  Created by 杨科军 on 2017/7/17.
//  Copyright © 2017年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KJBaseCustomTabBar;

@protocol KJBaseCustomTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickLiveButton:(KJBaseCustomTabBar *)tabBar;

@end

@interface KJBaseCustomTabBar : UITabBar

@property (nonatomic, assign) id<KJBaseCustomTabBarDelegate> tabbardelegate;

@end
