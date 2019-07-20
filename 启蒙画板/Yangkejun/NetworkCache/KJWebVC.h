//
//  KJWebVC.h
//  MoLiao
//
//  Created by 杨科军 on 2018/8/17.
//  Copyright © 2018年 杨科军. All rights reserved.
//  网页H5展示界面

#import "KJBaseViewController.h"

@interface KJWebVC : KJBaseViewController

@property (nonatomic, assign) BOOL isH5;    // H5页面
@property (nonatomic, strong) NSString *h5Type; // 网络类型
@property (nonatomic, strong) NSString *game_id;  // id

@property (nonatomic, strong) NSString *url;  // url

@end
