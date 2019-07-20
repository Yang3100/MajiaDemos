//
//  KJSelectView.h
//  星空指南针
//
//  Created by 杨科军 on 2018/10/21.
//  Copyright © 2018 杨科军. All rights reserved.
//  选择指针

#import <UIKit/UIKit.h>

@interface KJSelectView : UIView

+ (instancetype)createSelectView:(void(^)(KJSelectView *obj))block;

/// 更新数据
@property (nonatomic, readwrite, copy)void(^updateClicked)(NSString *str);

@end
