//
//  KJChangeUserInfoVC.h
//  MoLiao
//
//  Created by 杨科军 on 2018/7/25.
//  Copyright © 2018年 杨科军. All rights reserved.
//  修改用户名

typedef NS_ENUM (NSInteger, HNChangeUserInfoVCType){
    HNChangeUserInfoVCTypeNick     = 0,
    HNChangeUserInfoVCTypeIntro    = 1,
};

#import "KJBaseViewController.h"

@interface KJChangeNameVC : KJBaseViewController

@property (nonatomic, strong) void(^myBlock)(NSString *endString);
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) HNChangeUserInfoVCType vcType;

@end
