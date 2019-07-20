//
//  KJUserModel.m
//  跟我学英文
//
//  Created by 杨科军 on 2018/12/4.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJUserModel.h"

@implementation KJUserModel

+ (instancetype)initUserModelManager{
    static KJUserModel *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KJUserModel alloc]init];
    });
    return manager;
}

@end
