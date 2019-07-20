//
//  HNRequestManager.h
//  OptimalLive
//
//  Created by Sunwanwan on 2017/8/31.
//  Copyright © 2017年 HN. All rights reserved.
//  请求类

#import <Foundation/Foundation.h>

// 网络请求类型
typedef NS_ENUM (NSInteger, HNRequestMethodType){
    HNRequestMethodTypeGET     = 0,
    HNRequestMethodTypePOST    = 1,
};

// 请求数据返回的状态码
typedef NS_ENUM(NSUInteger, KJHTTPResponseCode){
    // CODE 对应值  (PS：根据自身项目去设置)
    KJHTTPResponseCodeSuccess  = 000,           // 请求成功
    KJHTTPResponseCodeNotLogin = 402,           // 用户尚未登录,或者Token失效
};

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FaildBlock)(NSError *error);

@interface HNRequestManager : NSObject

@property (nonatomic,copy)NSString *UrlStr;

/**
 *  图片上传API
 *  code : 请求接口API
 *  parameters : 请求参数
 *  headerParameters  : 请求头参数, 可为nil
 *  image : 图片， 可为nil
 *  success  : 请求成功返回
 *  faild  : 请求失败返回
 */
+ (void)uploadImageWithRequestAPICode:(NSString *)code
                    requestParameters:(NSDictionary *)parameters
                        requestHeader:(NSDictionary *)headerParameters
                                image:(UIImage *)image
                              success:(SuccessBlock)success
                                faild:(FaildBlock)faild;


/**
 *  视频上传API
 *  视频上传的code 在方法里面写了， 外部不用再传了
 *  fileName : 上传文件名称
 *  parameters : 请求参数
 *  headerParameters  : 请求头参数, 可为nil
 *  success  : 请求成功返回
 *  faild  : 请求失败返回
 */
+ (void)uploadVideoWithFileName:(NSString *)fileName
              requestParameters:(NSDictionary *)parameters
                  requestHeader:(NSDictionary *)headerParameters
                        success:(SuccessBlock)success
                          faild:(FaildBlock)faild;


/**
 *  取消请求
 */
+ (void)cancelAllLiveRequest;

/**
 *  请求API
 *  type : 请求方式
 *  code : 请求接口API
 *  parameters :  请求参数， 可为nil
 *  refreshCache  : 是否缓存请求数据   YES  or NO
 *  headerParameters  : 请求头参数, 可为nil
 *  success  : 请求成功返回
 *  faild  : 请求失败返回
 */
+ (void)sendRequestWithRequestMethodType:(HNRequestMethodType)type
                          requestAPICode:(NSString *)code
                            refreshCache:(BOOL)isCache
                       requestParameters:(NSDictionary *)parameters
                                 success:(SuccessBlock)success
                                   faild:(FaildBlock)faild;

@end
