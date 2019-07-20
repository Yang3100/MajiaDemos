//
//  YYCache+KJHelper.m
//  KJDevelopExample
//
//  Created by lx on 2018/6/8.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "YYCache+KJHelper.h"

/// 获取缓存的key
NSString *const KJSearchFarmsHistoryCacheKey = @"KJSearchFarmsHistoryCacheKey";

/// 整个应用的利用YYCache来做磁盘和内存缓存的文件名称，切记该文件只能使用YYCache来做处理 具有相同名称的多个实例将缓存不稳定
static NSString *const KJApplicationYYCacheName = @"com.yy.cache";
/// 整个应用的利用YYCache来做磁盘和内存缓存的文件目录，切记该文件只能使用YYCache来做处理
// 沙盒地址
static inline NSString *KJApplicationYYCachePath(){
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:KJApplicationYYCacheName];
    return cachePath;
}

@implementation YYCache (KJHelper)
+ (instancetype)sharedCache {
    static YYCache *sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [[YYCache alloc] initWithPath:KJApplicationYYCachePath()];
    });
    return sharedCache;
}
@end
