//
//  KJBaseNetWorking.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseNetWorking.h"
#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)

+ (NSString *)HNnetworking_md5:(NSString *)string;

@end

@implementation NSString (md5)

+ (NSString *)HNnetworking_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

@end

static AFHTTPSessionManager *kj_sharedManager = nil;
static NSDictionary *kj_httpHeaders = nil;
static NSTimeInterval kj_timeout = 60.0f;
static BOOL isArchiver = NO;
static UIImageView *netWorkbackImage = nil;

@interface KJBaseNetWorking()

@property(nonatomic,strong) UIImageView *backImage;

@end

@implementation KJBaseNetWorking
//@synthesize isGetArchiver = _isGetArchiver;

+ (AFHTTPSessionManager *)kj_manager{
    /*
     @synchronized()的作用是创建一个互斥锁，
     保证在同一时间内没有其它线程对self对象进行修改,起到线程的保护作用
     一般在公用变量的时候使用,如单例模式或者操作类的static变量中使用
    */
    @synchronized (self) {
        // 只要不切换baseurl，就一直使用同一个session manager
        if (kj_sharedManager == nil) {
            /***********  所有通过AF发送的请求, 都会在电池条上出现菊花提示  ***********/
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            // 编码
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            
            // 公用请求头
            for (NSString *key in kj_httpHeaders.allKeys) {
                if (kj_httpHeaders[key] != nil) {
                    [manager.requestSerializer setValue:kj_httpHeaders[key] forHTTPHeaderField:key];
                }
            }
            
            // 可接受的内容类型
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                      @"text/html",
                                                                                      @"text/json",
                                                                                      @"text/plain",
                                                                                      @"text/javascript",
                                                                                      @"text/xml",
                                                                                      @"image/*"]];
            // 设置请求超时时间
            manager.requestSerializer.timeoutInterval = kj_timeout;
            // 设置允许同时最大并发数量，过大容易出问题
            manager.operationQueue.maxConcurrentOperationCount = 3;
            
//            // 无条件的信任服务器上的证书
//            AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//            // 客户端是否信任非法证书
//            securityPolicy.allowInvalidCertificates = YES;
//            // 是否在证书域字段中验证域名
//            securityPolicy.validatesDomainName = NO;
//            manager.securityPolicy = securityPolicy;
            
            kj_sharedManager = manager;
        }
    }
    return kj_sharedManager;
}

- (void)setIsGetArchiver:(BOOL)isGetArchiver{
    isArchiver = isGetArchiver;
}

// 监听当前网络状态
+ (void)getCurrectNetStatus:(void(^)(NSString *status))netStatus{
    /***********  监听当前网络状态    *************/
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        !netStatus?:netStatus(AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/*!
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders {
    kj_httpHeaders = httpHeaders;
}
/**
 *    设置请求超时时间，默认为60秒
 *
 *    @param timeout 超时时间
 */
+ (void)setTimeout:(NSTimeInterval)timeout {
    kj_timeout = timeout;
}
// 缓存地址
static inline NSString *kj_cachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/KJNetworkingCaches"];
}
// 清除缓存
+ (void)clearCaches {
    NSString *directoryPath = kj_cachePath();
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
    }
}
// 获取缓存
+ (unsigned long long)totalCacheSize {
    NSString *directoryPath = kj_cachePath();
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    return total;
}

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void (^)(id, NSError *))completionHandler{
    AFHTTPSessionManager *manager = [self kj_manager];
    //拼接参数
    NSMutableDictionary *param = [NSMutableDictionary new];
    //特殊传入的参数
    [param addEntriesFromDictionary:parameters];
    //共同的参数
    [param addEntriesFromDictionary:[self commonParams]];
    return [manager POST:path parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        KJAppLog(@"服务器获取\n😍😍请求url:\n%@\n😎😎请求参数:%@\n😁😁返回数据:%@", task.currentRequest.URL.absoluteString,param,responseObject);
        !completionHandler?:completionHandler(responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        KJAppLog(@"失败反馈\n😍😍请求url:\n%@\n😎😎请求参数:%@\n😁😁错误数据:%@", task.currentRequest.URL.absoluteString,param,error);
        !completionHandler?:completionHandler(nil, error);
    }];
}

// 公用的请求参数
+ (NSMutableDictionary *)commonParams{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    
//    [paramDic setObject:kUDID forKey:@"device_id"];  // 设备ID
//    [paramDic setObject:@"IOS" forKey:@"app_os"];    // 系统
//    [paramDic setObject:kAPPVERSION forKey:@"app_version"]; // 当前APP版本
//
//    // 个人信息相关
//    if (![kTOKEN isEqualToString:@""]&&kTOKEN!=nil && !isIose) {
//        [paramDic setObject:kTOKEN forKey:@"access_token"];  // 用户的access_token, 由服务器下发
//    }
//    isIose=NO;
    return paramDic;
}

@end

