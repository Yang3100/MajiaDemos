//
//  HNHTTPRequestManager.m
//  BeautyLiveShow
//
//  Created by mac-333 on 16/7/2.
//  Copyright © 2016年 HHSX. All rights reserved.
//

#import "HNHTTPRequestManager.h"
#import "HNNetworking.h"
//#import "HNLoginViewController.h"

@implementation HNHTTPRequestManager
+ (instancetype)shareInstance{
    static HNHTTPRequestManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HNHTTPRequestManager alloc]init];
    });
    return manager;
}
- (void)reachabilityWithNet:(httpNoReachability)netStatus{
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
         switch (status){
             case AFNetworkReachabilityStatusUnknown:
                 //未知 回调处理
                 netStatus(AFNetworkReachabilityStatusUnknown);
                 break;
             case AFNetworkReachabilityStatusNotReachable:
                 // 回调处理
                 netStatus(AFNetworkReachabilityStatusNotReachable);
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 // 回调处理
                 netStatus(AFNetworkReachabilityStatusReachableViaWWAN);
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 // 回调处理
                 netStatus(AFNetworkReachabilityStatusReachableViaWiFi);
                 break;
             default:
                 break;
         }
     }];
}

- (void)getWithUrl:(NSString *)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
           success:(httpSuccess)success
              fail:(httpFailure)fail{
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    if([cookiesdata length]){
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }

    [HNNetworking getWithUrl:url
                refreshCache:refreshCache
                      params:params
                     success:^(id response){
                 //                         if (![response isKindOfClass:[NSDictionary class]]){
//                             [[UIApplication sharedApplication].keyWindow makeToast:noNetWorkTitle duration:1.5 position:CSToastPositionCenter];
//                             DLog(@"网络故障:URL = %@",url);
//                             return ;
//                         }
//                 //                         NSArray* array = [response allKeys];
//                         if (![array containsObject:@"result"]){
//                             [[UIApplication sharedApplication].keyWindow makeToast:noNetWorkTitle duration:1.5 position:CSToastPositionCenter];
//                             DLog(@"网络故障:URL = %@",url);
//                             return ;
//                         }
//                                          success(response);
                     } fail:^(NSError *error){
//                         [[UIApplication sharedApplication].keyWindow makeToast:noNetWorkTitle duration:1.5 position:CSToastPositionCenter];
//                         DLog(@"网络故障:URL = %@",url);
                         fail(error);
                     }];
}

- (void)getWithURL:(NSString*)url
      refreshCache:(BOOL)refreshCache
            params:(NSDictionary *)params
            requestHeader:(NSDictionary *)headerParameters
           success:(httpSuccess)success
              fail:(httpFailure)fail;{
    
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    if([cookiesdata length]){
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    
    [HNNetworking getWithUrl:url
                refreshCache:refreshCache
                      params:params
               requestHeader:headerParameters
                     success:^(id response){
        success(response);
    } fail:^(NSError *error){
        fail(error);
    }];
    
}





- (void)postWithUrl:(NSString *)url
       refreshCache:(BOOL)refreshCache
             params:(NSDictionary *)params
            success:(httpSuccess)success
               fail:(httpFailure)fail{
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    if([cookiesdata length]){
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    
    [HNNetworking postWithUrl:url
                 refreshCache:refreshCache
                       params:params
                      success:^(id response){
                                            //回调
                          success(response);
                                            if ([response isKindOfClass:[NSDictionary class]]){
                              //无效签名
                              if ([[response objectForKey:@"result"] integerValue] == 3002){
                                                            NSMutableDictionary *dicM = [[NSMutableDictionary alloc]init];
                                                            NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
                                  NSString *content = @"";
                                  if (data){
                                      content = [[NSString alloc] initWithData:data
                                                                      encoding:NSUTF8StringEncoding];
                                  }
                                  [dicM setValue:content forKey:@"params"];
                                  [dicM setValue:url forKey:@"api"];
                                  [dicM setValue:[response objectForKey:@"result"] forKey:@"state_code"];
//                          //                                  [[HNHTTPRequestManager shareInstance] postWithUrl:APIError refreshCache:YES params:dicM success:^(id responseObject){
//                              //                                  } fail:^(NSError *error){
//                              //                                  }];
                              }
                          }
                                                          } fail:^(NSError *error){
                                            fail(error);
                      }];
    
    
}
- (void)postWithUrl:(NSString*)url
        refreshCache:(BOOL)refreshCache
              params:(NSDictionary *)params
       requestHeader:(NSDictionary *)headerParameters
             success:(httpSuccess)success
                fail:(httpFailure)fail;{
    
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"Cookie"];
    if([cookiesdata length]){
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies){
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
    [HNNetworking postWithUrl:url refreshCache:refreshCache params:params requestHeader:headerParameters success:^(id response){
        //回调
        success(response);
        if ([response isKindOfClass:[NSDictionary class]]){
            //无效签名
            if ([[response objectForKey:@"result"] integerValue] == 3002){
                        NSMutableDictionary *dicM = [[NSMutableDictionary alloc]init];
                        NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
                NSString *content = @"";
                if (data){
                    content = [[NSString alloc] initWithData:data
                                                    encoding:NSUTF8StringEncoding];
                }
                [dicM setValue:content forKey:@"params"];
                [dicM setValue:url forKey:@"api"];
                [dicM setValue:[response objectForKey:@"result"] forKey:@"state_code"];
                //
                //                                  [[HNHTTPRequestManager shareInstance] postWithUrl:APIError refreshCache:YES params:dicM success:^(id responseObject){
                //
                //                                  } fail:^(NSError *error){
                //
                //                                  }];
            }
        }

    } fail:^(NSError *error){
        fail(error);
    }];
    
    
    
//    [HNNetworking postWithUrl:url
//                 refreshCache:refreshCache
//                       params:params
//                      success:^(id response){
//                          //回调
//                          success(response);
//                  //                          if ([response isKindOfClass:[NSDictionary class]]){
//                              //无效签名
//                              if ([[response objectForKey:@"result"] integerValue] == 3002){
//                          //                                  NSMutableDictionary *dicM = [[NSMutableDictionary alloc]init];
//                          //                                  NSData *data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
//                                  NSString *content = @"";
//                                  if (data){
//                                      content = [[NSString alloc] initWithData:data
//                                                                      encoding:NSUTF8StringEncoding];
//                                  }
//                                  [dicM setValue:content forKey:@"params"];
//                                  [dicM setValue:url forKey:@"api"];
//                                  [dicM setValue:[response objectForKey:@"result"] forKey:@"state_code"];
//                                  //
//                                  //                                  [[HNHTTPRequestManager shareInstance] postWithUrl:APIError refreshCache:YES params:dicM success:^(id responseObject){
//                                  //
//                                  //                                  } fail:^(NSError *error){
//                                  //
//                                  //                                  }];
//                              }
//                          }
//                  //                  //                      } fail:^(NSError *error){
//                  //                          fail(error);
//                      }];
//
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)cancelAllHttpRequest{
    [HNNetworking  cancelAllRequest];
}
//- (void)uploadWithImage:(UIImage *)image
//                    url:(NSString *)url
//               filename:(NSString *)filename
//                   name:(NSString *)name
//               mimeType:(NSString *)mimeType
//             parameters:(NSDictionary *)parameters
//               progress:(HNUploadProgress)progress
//                success:(httpSuccess)success
//                   fail:(httpFailure)fail
//{
//    [HNNetworking uploadWithImage:image url:url filename:filename name:name mimeType:mimeType parameters:parameters progress:^(int64_t bytesWritten, int64_t totalBytesWritten){
////    } success:^(id response){
//        success(response);
//    } fail:^(NSError *error){
//        fail(error);
//    }];
//}
//


@end
