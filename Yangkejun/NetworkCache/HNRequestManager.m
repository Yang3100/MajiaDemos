//
//  HNRequestManager.m
//  OptimalLive
//
//  Created by Sunwanwan on 2017/8/31.
//  Copyright © 2017年 HN. All rights reserved.
//

#import "HNRequestManager.h"
#import "HNHTTPRequestManager.h"

#define REQUEST           @"http://yintolo.net/api.php/EncryptApi/"  // 外网正式网站
//#define REQUEST           @"https://indrah.cn/api.php/SecretApi/"
#define UpImageDataUrl    @"http://static.eagleeyetv.com.cn/upload_img.php"

#define UpLoadVideo @"/upload/video.php"   ///上传视频
#define VideoPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"anchor.mp4"]

@implementation HNRequestManager

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
                                faild:(FaildBlock)faild{
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *imageURL = UpImageDataUrl;
    NSData * imageData = nil;
    //    imageData = UIImagePNGRepresentation(image);
    //    if (imageData.length == 0){
    //        imageData = UIImageJPEGRepresentation(image, 1.0);
    //    }
    imageData = [KJTools zipImageWithImage:image withMaxSize:1500];
    [manager POST:imageURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"1.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress){
        // 上传进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSDictionary*dictionary=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        success(dictionary);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        faild(error);
    }];
}

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
                          faild:(FaildBlock)faild{
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@",REQUEST,UpLoadVideo];
    NSURL* url = [NSURL fileURLWithPath:VideoPath];
    NSData* videoData = [NSData dataWithContentsOfURL:url];
    
    [manager POST:imageURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData){
        [formData appendPartWithFileData:videoData name:@"file" fileName:fileName mimeType:@"mp4"];
    } progress:^(NSProgress * _Nonnull uploadProgress){
        // 上传进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSDictionary*dictionary=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        success(dictionary);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
        faild(error);
    }];
}

// 取消网络请求
+ (void)cancelAllLiveRequest{
    [[HNHTTPRequestManager shareInstance]cancelAllHttpRequest];
}

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
                                   faild:(FaildBlock)faild{
    // 拼接请求的接口
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",REQUEST,code];
    //拼接参数
    //特殊传入的参数 - parameters
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    //共同的参数
    [dict addEntriesFromDictionary:[self commonParams]];
    
    // 加密
    NSString *str = [KJEncryptTool get16Num];
    NSString *key = [KJEncryptTool RSAEncrypt:str];
    NSString *eightString = [str substringToIndex:8];
    NSString *msg = [KJEncryptTool DESEncrypt:[KJTools convertToJsonData:dict] key:eightString];
    //    NSLog(@"---------\n%@\n%@",eightString,msg);
    NSDictionary *param = @{@"key":key,@"msg":msg};
    
    // GET请求方式
    if (type == HNRequestMethodTypeGET){
        [[HNHTTPRequestManager shareInstance] getWithUrl:requestUrl refreshCache:isCache params:param success:^(id responseObject){
            success(responseObject);
        } fail:^(NSError *error){
           faild(error);
        }];
    }
    // POST请求方式
    else if (type == HNRequestMethodTypePOST){
        [[HNHTTPRequestManager shareInstance] postWithUrl:requestUrl refreshCache:isCache params:param success:^(id responseObject){
            success(responseObject);
                // 在这里判断数据是否正确
            // 解析code
            } fail:^(NSError *error){
            faild(error);
        }];
    }
}


#pragma mark - 公用的请求参数
+ (NSMutableDictionary *)commonParams{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    
//    [paramDic setObject:@"uuid" forKey:@"device_id"];  // 设备ID
//    [paramDic setObject:@"IOS" forKey:@"app_os"];    // 系统
//    [paramDic setObject:@"app_version" forKey:@"app_version"]; // 当前APP版本
    
    [paramDic setObject:@"1" forKey:@"m_id"]; // m_id
    
//    // 个人信息相关
//    if (![kTOKEN isEqualToString:@""]&&kTOKEN!=nil){
//        [paramDic setObject:kTOKEN forKey:@"access_token"];  // 用户的access_token, 由服务器下发
//    }
    
    return paramDic;
}

#pragma mark - 打印请求日志
- (void)_HTTPRequestLog:(NSURLSessionTask *)task body:params error:(NSError *)error{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>👇 REQUEST FINISH 👇>>>>>>>>>>>>>>>>>>>>>>>>>>");
    NSLog(@"Request %@=======>:%@", error? @"失败":@"成功", task.currentRequest.URL.absoluteString);
    NSLog(@"requestBody======>:%@", params);
    NSLog(@"requstHeader=====>:%@", task.currentRequest.allHTTPHeaderFields);
    NSLog(@"response=========>:%@", task.response);
    NSLog(@"error============>:%@", error);
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<👆 REQUEST FINISH 👆<<<<<<<<<<<<<<<<<<<<<<<<<<");
}

@end
