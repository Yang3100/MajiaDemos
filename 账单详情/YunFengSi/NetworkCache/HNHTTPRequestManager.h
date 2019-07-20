//
//  HNHTTPRequestManager.h
//  BeautyLiveShow
//
//  Created by mac-333 on 16/7/2.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// 成功的回调
typedef void (^httpSuccess)(id responseObject);
// 失败的回调
typedef void (^httpFailure)(NSError *error);
// 网络变化的回调
typedef void (^httpNoReachability)(AFNetworkReachabilityStatus status);
// 所有的接口返回值均为NSURLSessionTask
typedef NSURLSessionTask HNURLSessionTask;

@interface HNHTTPRequestManager : NSObject

+ (instancetype)shareInstance;
// 监测网络状态
- (void)reachabilityWithNet:(httpNoReachability)netStatus;

// 取消网络请求
- (void)cancelAllHttpRequest;

/*!
 *
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url          接口路径
 *  @param refreshCache 是否刷新缓存
 *  @param params       接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success      接口成功请求到数据的回调
 *  @param fail         接口请求数据失败的回调
 *
 */
- (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
           success:(httpSuccess)success
              fail:(httpFailure)fail;

/*!
 *
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url          接口路径
 *  @param refreshCache 是否刷新缓存
 *  @param params       接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success      接口成功请求到数据的回调
 *  @param headerParameters    接口请求头数据
 *  @param fail         接口请求数据失败的回调
 *
 */
- (void)getWithURL:(NSString*)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
            requestHeader:(NSDictionary *)headerParameters
            success:(httpSuccess)success
              fail:(httpFailure)fail;

/*!
 *
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径
 *  @param params  接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 */
- (void)postWithUrl:(NSString *)url
       refreshCache:(BOOL)refreshCache
             params:(NSDictionary *)params
            success:(httpSuccess)success
               fail:(httpFailure)fail;

/*!
 *
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url          接口路径
 *  @param refreshCache 是否刷新缓存
 *  @param params       接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success      接口成功请求到数据的回调
 *  @param headerParameters    接口请求头数据
 *  @param fail         接口请求数据失败的回调
 *
 */
- (void)postWithUrl:(NSString*)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
     requestHeader:(NSDictionary *)headerParameters
           success:(httpSuccess)success
              fail:(httpFailure)fail;

/**
 *
 *	图片上传接口，若不指定baseurl，可传完整的url
 *
 *	@param image		图片对象
 *	@param url			上传图片的接口路径，如/path/images/
 *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *	@param name			与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *	@param mimeType		默认为image/jpeg
 *	@param parameters	参数
 *	@param progress		上传进度
 *	@param success		上传成功回调
 *	@param fail			上传失败回调

 */
//- (void)uploadWithImage:(UIImage *)image
//                    url:(NSString *)url
//               filename:(NSString *)filename
//                   name:(NSString *)name
//               mimeType:(NSString *)mimeType
//             parameters:(NSDictionary *)parameters
//               progress:(HNUploadProgress)progress
//                success:(httpSuccess)success
//                   fail:(httpFailure)fail;
//



@end
