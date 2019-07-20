//
//  KJCalculatorView.h
//  袋鼠记
//
//  Created by 杨科军 on 2018/10/16.
//  Copyright © 2018年 杨科军. All rights reserved.
//  计算器面板

#import <UIKit/UIKit.h>

@interface KJCalculatorView : KJBaseView

// KVO - 键值监听    
@property(nonatomic,copy) NSString *result;

/// 更新数据
@property (nonatomic, readwrite, copy)void(^updateClicked)(NSString *str);

/// 点击"完成"
@property (nonatomic, readwrite, copy)void(^completeClicked)(NSString *str);

/// 点击"+"
@property (nonatomic, readwrite, copy)void(^addClicked)(void);

/// 点击"-"
@property (nonatomic, readwrite, copy)void(^subClicked)(void);

/// 点击"删除"
@property (nonatomic, readwrite, copy)void(^delClicked)(void);

/// 点击"."
@property (nonatomic, readwrite, copy)void(^dotClicked)(void);

/// 点击"数字"
@property (nonatomic, readwrite, copy)void(^numClicked)(int num);


@end
