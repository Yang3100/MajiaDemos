//
//  KJPersionSignViewController.h
//  OptimalLive
//
//  Created by 杨科军 on 2017/10/20.
//  Copyright © 2017年 杨科军. All rights reserved.
//  个性签名

#import "KJBaseViewController.h"

@interface KJPersionSignViewController : KJBaseViewController

@property (nonatomic,copy)NSString      *infro;
@property (nonatomic, strong) void(^myBlock)(NSString *endString);
@end

