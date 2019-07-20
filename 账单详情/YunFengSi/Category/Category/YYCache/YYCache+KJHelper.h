//
//  YYCache+KJHelper.h
//  KJDevelopExample
//
//  Created by lx on 2018/6/8.
//  Copyright © 2018年 杨科军. All rights reserved.
//  缓存相关 - 获取缓存路径

#import <YYKit/YYCache.h>

/// 首页搜索历史 获取缓存的key
FOUNDATION_EXTERN NSString * _Nullable const KJSearchFarmsHistoryCacheKey;

@interface YYCache (KJHelper)
/// 单例
+ (instancetype _Nullable )sharedCache;

@end
