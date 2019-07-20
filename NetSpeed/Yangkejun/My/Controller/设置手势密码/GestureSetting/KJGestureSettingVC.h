//
//  KJGestureSettingVC.h
//  LZAccount
//
//  Created by 杨科军 on 16/6/2.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBaseViewController.h"

typedef void (^PopBackBlock)(void);

@interface KJGestureSettingVC : KJBaseViewController

/**
 返回上一级页面时调用。请使用的人，注意避免 block造成retain-cycle
 */
@property (nonatomic, copy) PopBackBlock popBackBlock;
@property (strong, nonatomic)UIView *contendView;
@end
