//
//  KJNetManager.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//  所有网络请求接口

#import "KJBaseNetWorking.h"

#define KJ_CODE [[responseObj valueForKey:@"code"] integerValue]

@interface KJNetManager : KJBaseNetWorking

#pragma mark - 登陆注册版块

// 单例网络
+ (instancetype)initNetManager;

// 登陆
+ (void)LoginForIphoneIsNum:(NSString*)phone Password:(NSString*)password  completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

// 所有单词
+ (void)GetAllWord:(NSString*)userid completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

// 学习过的单词
+ (void)GetStudyedWord:(NSString*)userid completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

@end














