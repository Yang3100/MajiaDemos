//
//  KJNetManager.m
//  MoLiao
//
//  Created by 杨科军 on 2018/7/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJNetManager.h"

@implementation KJNetManager

// 单例网络
+ (instancetype)initNetManager{
    static KJNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KJNetManager alloc]init];
    });
    return manager;
}

+ (void)LoginForIphoneIsNum:(NSString*)phone Password:(NSString*)password  completionHandler:(void(^)(id responseObj, NSError *error))completionHandler{
    NSDictionary *parameters = @{@"phone":phone,
                                 @"password":password,
                                 };
    [self POST:@"http://142.4.117.17:8095/api/login/login" parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler(responseObj,error);
    }];
}

// 所有单词
+ (void)GetAllWord:(NSString*)userid completionHandler:(void(^)(id responseObj, NSError *error))completionHandler{
    NSDictionary *parameters = @{@"userid":userid};
    [self POST:@"http://142.4.117.17:8095/api/word/alldata" parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler(responseObj,error);
    }];
}

// 学习过的单词
+ (void)GetStudyedWord:(NSString*)userid completionHandler:(void(^)(id responseObj, NSError *error))completionHandler{
    NSDictionary *parameters = @{@"userid":userid};
    [self POST:@"http://142.4.117.17:8095/api/word/studylist" parameters:parameters completionHandler:^(id responseObj, NSError *error) {
        !completionHandler ?: completionHandler(responseObj,error);
    }];
}


@end
