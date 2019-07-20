//
//  KJBaseNetWorking.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//  基础网络请求类

#import <Foundation/Foundation.h>

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define KJAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define KJAppLog(s, ... )
#endif


@interface KJBaseNetWorking : NSObject

@property(nonatomic,assign) BOOL isGetArchiver;  // 是否需要获取缓存数据,默认为no

// 监听当前网络状态
+ (void)getCurrectNetStatus:(void(^)(NSString *status))netStatus;

// 配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

// 设置请求超时时间，默认为60秒
+ (void)setTimeout:(NSTimeInterval)timeout;

// 获取缓存总大小/bytes
+ (unsigned long long)totalCacheSize;

// 清除缓存
+ (void)clearCaches;

// post请求方式
+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

@end
