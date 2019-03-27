//
//  KJBirthVC.h
//  HawkeyeLive
//
//  Created by 杨科军 on 2018/5/22.
//  Copyright © 2018年 HN. All rights reserved.
//  出生日期

#import "KJBaseViewController.h"

@interface KJBirthVC : KJBaseViewController

// 数据修改成功之后的回调
@property(nonatomic,strong) void(^sucessBlock)(NSString *birth);

@property(nonatomic,strong) NSString *birthTime;
//@property(nonatomic,strong) HNUserModel *kj_dataModel;

@end
