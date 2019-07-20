//
//  AppDelegate+KJCustom.h
//  YunFengSi
//
//  Created by 杨科军 on 2018/9/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (KJCustom)

- (void)configSystem:(NSDictionary *)options;
@property (nonatomic, readonly, getter=isOnline)BOOL online;

@end
